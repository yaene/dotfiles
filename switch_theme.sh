#!/bin/bash

# Parse arguments before and after '--'
script_args=()
extra_args=()
found_delim=0

for arg in "$@"; do
    if [ "$found_delim" -eq 0 ]; then
        if [ "$arg" = "--" ]; then
            found_delim=1
        else
            script_args+=("$arg")
        fi
    else
        extra_args+=("$arg")
    fi
done

# The wallpaper file is the first argument before the delimiter.
WALLPAPER="${script_args[0]}"

# Run script with any extra arguments passed after '--'
wallust run "$WALLPAPER" "${extra_args[@]}" --check-contrast

# Reapply spice
spicetify apply

# Set wallpaper
swww img "$WALLPAPER"

# Update GTK theme
zsh ~/.themes/gen_wallust_gtk.sh

