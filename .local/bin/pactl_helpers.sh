#!/bin/bash

get_default_device() {
	local device="$1"

	local default
	case "$device" in
	"sink") default="@DEFAULT_SINK@" ;;
	"source") default="@DEFAULT_SOURCE@" ;;
	*)
		printf "Invalid device: %s\n" "$device" >&2
		return 1
		;;
	esac

	printf "%s" "$default"
}

get_volume() {
	local device=$1

	local default
	if ! default=$(get_default_device "$device"); then
		return 1
	fi

	local -r left=$(pactl get-"$device"-volume "$default" | head -1 | awk '{print $5}' | tr -d '%')
	local -r right=$(pactl get-"$device"-volume "$default" | head -1 | awk '{print $12}' | tr -d '%')

	printf "%d" $(((left + right) / 2))
}

set_volume() {
	local device="$1"

	local default
	if ! default=$(get_default_device "$device"); then
		return 1
	fi

	local volume="$2"
	if ! [[ $volume =~ ^[0-9]+$ ]]; then
		printf "Invalid volume: %s\n" "$volume" >&2
		return 1
	fi

	local sign="$3"
	if ! [[ $sign =~ ^('+'|'-'|'')$ ]]; then
		printf "Invalid sign: %s\n" "$sign" >&2
		return 1
	fi

	pactl set-"$device"-volume "$default" "$sign$volume%"
}

get_mute() {
	local device="$1"

	local default
	if ! default=$(get_default_device "$device"); then
		return 1
	fi

	local -r is_mute=$(pactl get-"$device"-mute "$default" | awk '{print $2}')

	if [[ $is_mute == "yes" ]]; then
		printf "true"
	else
		printf "false"
	fi
}

set_mute() {
	local device="$1"
	local value="$2"

	local default
	if ! default=$(get_default_device "$device"); then
		return 1
	fi

	case "$value" in
	"true") pactl set-"$device"-mute "$default" 1 ;;
	"false") pactl set-"$device"-mute "$default" 0 ;;
	"toggle") pactl set-"$device"-mute "$default" toggle ;;
	*)
		printf "Invalid mute value: %s\n" "$value" >&2
		return 1
		;;
	esac
}
