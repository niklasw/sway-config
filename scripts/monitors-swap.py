#!/usr/bin/env python3

from subprocess import Popen, PIPE
import json
import sys


def get_outputs():
    cmd = 'swaymsg -t get_outputs'.split()
    p = Popen(cmd, stdout=PIPE, stderr=PIPE)
    p.wait()

    if p.returncode == 0:
        msg = json.loads(p.stdout.read().decode())
    else:
        msg = {'error': 'process error',
               'exit': p.returncode,
               'message': p.stderr.read().decode()}

    return msg


def set_output(name: str, x: int, y=0):
    cmd = ['swaymsg', f'output {name} pos {x} {y}']
    p = Popen(cmd, stdout=PIPE, stderr=PIPE)
    p.wait()

    if p.returncode == 0:
        return True
    else:
        print(f'set_output command failed with code {p.returncode}')
        print(p.stderr.read().decode())
        return False


def parse_monitor(monitor: list):
    return {'name': monitor.get('name'),
            'x': monitor.get('rect').get('x'),
            'width': monitor.get('rect').get('width'),
            'height': monitor.get('rect').get('height')}


def sort_monitors_by_x(monitors):
    return sorted(monitors, key=lambda d: d.get('x'), reverse=False)


def show_monitors_orientation(monitors):
    print('Current monitors horisontal orientation:\n')
    for m in monitors:
        print(f'|{m.get("name")}|', end=' ')
    print('\n')


if __name__ == '__main__':
    outputs = get_outputs()
    monitors = []
    if isinstance(outputs, list):
        monitors = sort_monitors_by_x((parse_monitor(m) for m in outputs))
    else:
        print('Not enough monitors found')
        print(outputs)
        sys.exit(1)

    show_monitors_orientation(monitors)

    if input('Reverse? [y/N]: ') == 'y':
        # swaymsg 'output eDP-1 pos 1920 0' ; swaymsg 'output DP-2 pos 0 0'
        monitors.reverse()
        next_x = 0
        for m in monitors:
            set_output(m.get('name'), next_x, 0)
            next_x += m.get('width')
