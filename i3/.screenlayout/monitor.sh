#!/bin/bash

if xrandr | grep "DP-2-1 connected"; then
    # Configure monitors for HDMI connection
    xrandr --output DP-2-1 --auto --primary --output DP-1-1 --off
else
    # Configure monitors for internal display only
    xrandr --output DP-1-1 --auto --primary --output DP-2-1 --off
fi
