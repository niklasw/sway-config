#!/usr/bin/env sh

source $(dirname $0)/functions.sh

export BACKLIGHT_DIR="/sys/class/backlight/intel_backlight"
export MIN_BRIGHT=10
backlight $@
