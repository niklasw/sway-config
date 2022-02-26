#!/usr/bin/env sh

function usage()
{
    cat << EOF
    Usage:
        $(basename $0)
EOF
}

function display_list()
{
    D=""
    for item in $(swaymsg -t get_outputs|jq .[].name | xargs)
    do
        D="$D$item|"
    done
    echo $D
}

function selector_window()
{
    zenity  --forms \
            --add-combo="Display" \
            --combo-values="$(display_list)" \
            --add-combo="Scale" \
            --combo-values="0.5|1.0|2.0"
}

function sway_scale()
{
    swaymsg output $1 scale $2
}

combo=$(selector_window)

display=$(cut -d "|" -f 1 <<< $combo)
scale=$(cut -d "|" -f 2 <<< $combo)

if [[ -n "$display" && -n "$scale" ]]
then
    sway_scale $display $scale
fi




