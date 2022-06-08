#!/usr/bin/env sh

source $(dirname $0)/functions.sh

export BACKLIGHT_DIR="/sys/class/leds/asus::kbd_backlight"
export MIN_BRIGHT=0
backlight $@
