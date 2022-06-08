#!/usr/bin/env bash

export SWAY_FUNCTIONS=~/.config/sway/scripts/functions.sh

function toggle_waybar()
{
    if pgrep waybar
    then
        pkill waybar > /dev/null 2>&1  
    else
        waybar > /dev/null 2>&1 &
    fi
}

function backlight_usage()
{
    cat << EOF
    From $SWAY_FUNCTIONS

    Change screen brightness between allowed extremes.
    WILL CALL sudo

    Usage:
    $0 <i|d> <value>

EOF
}

function backlight()
{
    [[ -d "$BACKLIGHT_DIR" && -n "$MIN_BRIGHT" ]] \
    || { echo "BACKLIGHT_DIR and MIN_BRIGHT must be set."; \
             return 1; }
    
    MAX_BRIGHT=$(< $BACKLIGHT_DIR/max_brightness)
    MIN_BRIGHT=${MIN_BRIGHT:=0}
    CURRENT_BRIGHT=$(< $BACKLIGHT_DIR/brightness)
    
    INCREASE=0
    DECREASE=0
    
    while (( $# > 0 ))
    do
        case $1 in
            i)
                INCREASE=$2
                shift 2
                ;;
            d)
                DECREASE=$2
                shift 2
                ;;
            *)
                backlight_usage
                return 1
                break
                ;;
        esac
    done
    
    CHANGE=$((INCREASE - DECREASE))
    NEW_BRIGHT=$((CURRENT_BRIGHT + CHANGE))
    
    if ((NEW_BRIGHT >= MIN_BRIGHT && NEW_BRIGHT <= MAX_BRIGHT))
    then
        echo $NEW_BRIGHT | sudo tee $BACKLIGHT_DIR/brightness
    fi
}

