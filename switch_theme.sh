WALLPAPER=$1

wallust run "$WALLPAPER" --check-contrast

# reapply spice
spicetify apply

# set wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"

# update gtk theme
zsh ~/.themes/gen_wallust_gtk.sh



