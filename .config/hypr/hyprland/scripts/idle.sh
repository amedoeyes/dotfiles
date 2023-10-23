#!/bin/bash

swayidle -w \
	timeout 300 'brightnessctl -s s 5%' \
	resume 'brightnessctl -r' \
	timeout 600 'swaylock -f' \
	timeout 600 'hyprctl dispatch dpms off' \
	resume 'hyprctl dispatch dpms on' \
	timeout 900 'systemctl suspend' \
	before-sleep 'swaylock - f'
