#!/bin/env python3

import os
import sys

from mutagen.mp3 import MP3
from mutagen.oggvorbis import OggVorbis as OGG


def extract_lyrics_from_ogg(ogg_file: str, lyrics_folder: str):
    """
    Extraer la letra de los metadatos de ogg_file y la guarda en un archivo .txt
    con el mismo nombre en lyrics_folder
    """

    try:
        audio = OGG(ogg_file)
        lyrics = audio["lyrics"][0]
        if lyrics[0]:
            artist = audio["albumartists"][0]
            song = audio["title"][0]
            txt_file = os.path.join(lyrics_folder, f"{artist} - {song}.txt")
            with open(txt_file, "w", encoding="utf-8") as f:
                f.write(lyrics)
            print(f"Letra extraida y guardada en {txt_file}")
        else:
            print(f"El archivo {ogg_file} no tiene letra")

    except Exception as e:
        print(f"Error al procesar {ogg_file}: {e}")


def extract_lyrics_from_mp3(mp3_file: str, lyrics_folder: str):
    """
    Extraer la letra de los metadatos de mp3_file y la guarda en un archivo .txt
    con el mismo nombre en lyrics_folder
    """

    try:
        audio = MP3(mp3_file)
        lyrics = ""
        for k in audio.keys():
            if k.startswith("USLT::"):
                lyrics = audio[k].text
                break

        if lyrics:
            artist = audio["TPE1"]
            song = audio["TIT2"]
            txt_file = os.path.join(lyrics_folder, f"{artist} - {song}.txt")
            with open(txt_file, "w", encoding="utf-8") as f:
                f.write(lyrics)
            print(f"Letra extraida y guardada en {txt_file}")

        else:
            print(f"El archivo {mp3_file} no tiene letra")
    except Exception as e:
        print(f"Error al procesar {mp3_file}: {e}")


def process_path(path: str, lyrics_folder: str):
    """
    Recorrer path buscando archivos de música. Puede ser un archivo o un directorio
    """

    def process_by_filetype(filename: str):
        """
        Función auxiliar para seleccionar el decodificador correcto para el archivo
        """
        if filename.endswith(".mp3"):
            extract_lyrics_from_mp3(filename, lyrics_folder)
        elif filename.endswith(".ogg"):
            extract_lyrics_from_ogg(filename, lyrics_folder)
        else:
            print(
                f"Error: '{filename}' no tiene una extensión de archivo conocida (MP3, OGG o FLAC). Ignorando..."
            )

    if os.path.isdir(path):
        for root, _, files in os.walk(path):
            for file in files:
                full_path = os.path.join(root, file)
                process_by_filetype(full_path)
    elif os.path.isfile(path):
        process_by_filetype(path)
    else:
        print(f"La ruta {path} no es un archivo ni un directorio válido")
        sys.exit(1)


if __name__ == "__main__":
    # Comprobación de errores
    if len(sys.argv) != 2:
        print("Uso: [python] extract-lyrics.py <directorio>")
        sys.exit(1)

    # Ayuda
    if sys.argv[1] in {"-h", "--help"}:
        print("Uso: [python] extract-lyrics.py <directorio>")
        sys.exit(0)

    # Carpetas para leer/escribir
    lyrics_folder = os.path.expanduser("~/.local/share/lyrics")
    os.makedirs(lyrics_folder, exist_ok=True)

    music_folder = os.path.expanduser(sys.argv[1])

    # le damos duro
    process_path(music_folder, lyrics_folder)
