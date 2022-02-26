#!/usr/bin/env sh

function usage()
{
    cat << EOF
    Usage:
        $(basename $0)
EOF
}

function select_display()
{
    select display in Quit Help $(swaymsg -t get_outputs|jq '.[].name' | xargs)
    do
        case $display in
            "Help")
                usage
                exit 1
                ;;
            "Quit")
                exit 0
                ;;
            *)
                break
                ;;
        esac
    done

    if [ -z $display ]
    then
        echo "Display selection failed"
        exit 1
    fi
    echo $display
}

function sway_scale()
{
    swaymsg output $1 scale $2
}

select_display

read -p "Scale factor: " scale

read -p "Scale $display with factor $scale ?"

sway_scale $display $scale




