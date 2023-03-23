#!/usr/bin/env sh

source $(dirname $0)/functions.sh

export BACKLIGHT_DIR="/sys/class/backlight/amdgpu_bl1"
export MIN_BRIGHT=10
backlight $@
