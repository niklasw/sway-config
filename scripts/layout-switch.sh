#!/usr/bin/env sh

LAYOUT0=0
LAYOUT1=1

function get_layout()
{
    swaymsg -t get_inputs |awk '/xkb_active_layout_index/ {print int($2);exit;}'
}

LAYOUT=$(get_layout)

if [[ "$LAYOUT" == $LAYOUT1  ]]
then
    swaymsg input "type:keyboard" xkb_switch_layout $LAYOUT0
elif [[ "$LAYOUT" == $LAYOUT0 ]]
then
    swaymsg input "type:keyboard" xkb_switch_layout $LAYOUT1
else
    echo -e "$LAYOUT unexpected"
fi

