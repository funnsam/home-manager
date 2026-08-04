shopt -s extglob
cp * ~/.config/waybar
sed -i "s/@@TEMPERATUREZONE@@/0/g" ~/.config/waybar/config.jsonc
pkill waybar
sleep 0.5
waybar &
