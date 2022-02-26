#!/usr/bin/env sh

now=$(date +%Y-%m-%d:%H.%M.%S)
REC_FILE=~/tmp/screen-wf-recorder.mp4
LOG_FILE=/tmp/screen-recorder.log

if pgrep wf-recorder
then
    pkill --signal SIGINT wf-recorder
else
    wf-recorder -f $REC_FILE -g "$(slurp)" 2>&1 > $LOG_FILE $@ &
fi
