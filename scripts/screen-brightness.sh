#!/usr/bin/env sh

function usage()
{
    cat << EOF

    Change screen brightness between allowed extremes.
    MUST BE RUN AS ROOT.

    Usage:
    $(basename $0) <i|d> <value>

EOF
    exit 1
}

[[ $(id -u) == 0 ]] || { sudo $0 $@; exit 0; }

BACKLIGHT_DIR=/sys/class/backlight/intel_backlight

MAX_BRIGHT=$(< $BACKLIGHT_DIR/max_brightness)
MIN_BRIGHT=10
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
            usage
            break
            ;;
    esac
done

CHANGE=$((INCREASE - DECREASE))
NEW_BRIGHT=$((CURRENT_BRIGHT + CHANGE))

if ((NEW_BRIGHT >= MIN_BRIGHT && NEW_BRIGHT <= MAX_BRIGHT))
then
    echo $NEW_BRIGHT > $BACKLIGHT_DIR/brightness
fi



