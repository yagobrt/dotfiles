#!/bin/bash
# Set paths:
# Output file is in your dotfiles-synced directory via the symlink at ~/.local/share/emoji.txt
OUTPUT_FILE="$DOTFILES_HOME/.local/share/emoji.txt"
# Cache file to store the last downloaded raw emoji data
CACHE_FILE="$XDG_CACHE_HOME/emoji-test.txt"
mkdir -p "$(dirname "$CACHE_FILE")"

# URL for the latest Unicode Emoji Test file
URL="https://unicode.org/Public/emoji/latest/emoji-test.txt"

# Temporary file for the new download
TEMP_FILE=$(mktemp)

echo "Checking for updates..."
# Use curl with -z option to download only if newer than CACHE_FILE.
# The -w flag outputs the HTTP code so we can check for a 304.
HTTP_CODE=$(curl -s -w "%{http_code}" -z "$CACHE_FILE" -o "$TEMP_FILE" "$URL")

if [ "$HTTP_CODE" = "304" ]; then
    echo "No new updates found."
    rm "$TEMP_FILE"
    exit 0
fi

echo "New version found. Processing emoji data..."

# Update the cache with the new raw file.
mv "$TEMP_FILE" "$CACHE_FILE"

# Remove any old output file
rm -f "$OUTPUT_FILE"

current_category=""

# Process the cache file line by line
while IFS= read -r line; do
    # Detect and report group changes (lines that start with "# group:")
    if [[ $line == \#\ group:* ]]; then
         new_category=${line#\# group: }
         if [[ $new_category != "$current_category" ]]; then
             current_category="$new_category"
             echo "Processing category: $current_category"
         fi
         continue
    fi

    # Skip comment and empty lines (but not the group headers)
    if [[ $line == \#* ]] || [[ -z $line ]]; then
         continue
    fi

    # Process only fully-qualified emoji lines
    if [[ $line == *"fully-qualified"* ]]; then
         # Skip lines that contain skin tone modifiers (U+1F3FB to U+1F3FF)
         if [[ $line =~ 1F3FB|1F3FC|1F3FD|1F3FE|1F3FF ]]; then
              continue
         fi
         # Extract the portion after the '#' character.
         # Expected format: "… ; fully-qualified  # 😀 E1.0 grinning face"
         info=$(echo "$line" | sed 's/.*# //')
         # Remove the emoji version (e.g., "E1.0 ") from the beginning
         emoji_and_name=$(echo "$info" | sed -E 's/E[0-9]+\.[0-9]+/emoji:/')
         # Append the emoji and its name to the output file
         echo "$emoji_and_name" >> "$OUTPUT_FILE"
    fi
done < "$CACHE_FILE"

echo "Done. Updated emoji list saved to $OUTPUT_FILE"
