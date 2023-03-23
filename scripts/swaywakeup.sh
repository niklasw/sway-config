export SWAYSOCK=$(gawk 'BEGIN {RS="\0"; FS="="} $1 == "SWAYSOCK" {print $2}' /proc/$(pgrep -o swaybg)/environ)

swaymsg "output * dpms on"
