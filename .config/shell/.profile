# Source XDG definitions
. ~/.config/shell/xdg-cleanup 

# Set PATH to include custom binaries
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Golang
if [ -d "/usr/local/go/bin" ] ; then
   PATH="$PATH:/usr/local/go/bin"
fi

if [ -d "$GOPATH/bin" ]; then
	PATH="$PATH:$GOPATH/bin/"
fi

# Rust
. "$CARGO_HOME/env"

# Default programs:
export EDITOR="nvim"
export VISUAL="nvim"

# Set default shell
export SHELL="/usr/bin/zsh"
