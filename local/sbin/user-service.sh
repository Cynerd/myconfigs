#!/bin/sh
set -e

[ -z "$1" ] && {echo "Run this script only from user-service file!" && exit 1}

# Name of service
NAME="$(basename "$1")"
SERVICE="$1"

# Source input file
. "$1"
shift

OP="status"
Q=true
# Parse arguments
while [ -n "$1" ]; do
	case "$1" in
		-h|--help)
			echo "User service: $NAME"
			echo " $description"
			echo "$SERVICE [OPTION]... OPERATION"
			echo " Options:"
			echo "  -q - be quiet"
			echo " Operations:"
			echo "  status - show status of service"
			echo "  start - start service"
			echo "  stop - stop service"
			echo "  restart - restart service"
			echo "  ifrestart - restart service if it's running"
			;;
		-q)
			Q=false
			;;
		status|start|stop|restart)
			OP="$1"
			;;
		*)
			echo "Unknown argument: $1"
			exit 1
			;;
	esac
	shift
done

case "$OP" in
	status)
		if status; then
			$Q && echo "Service $NAME is running"
			exit 0
		else
			$Q && echo "Service $NAME is not running"
			exit 1
		fi
		;;
	start)
		$Q && echo -n "Starting service $NAME..."
		if start; then
			$Q && echo "	ok"
		else
			$Q && echo "	fail"
			exit 1
		fi
		;;
	stop)
		$Q && echo -n "Stopping service $NAME..."
		if stop; then
			$Q && echo "	ok"
		else
			$Q && echo "	fail"
			exit 1
		fi
		;;
	restart)
		$Q && echo "Restarting service $NAME..."
		if ! stop; then
			$Q && echo "	stop failed"
			exit 1
		fi
		if start; then
			$Q && echo "	ok"
		else
			$Q && echo "	start failed"
			exit 1
		fi
		;;
	ifrestart)
		$Q && echo "Restarting service $NAME..."
		if status; then
			if ! stop; then
				$Q && echo "	stop failed"
				exit 1
			fi
			if start; then
				$Q && echo "	ok"
			else
				$Q && echo "	start failed"
				exit 1
			fi
		fi
		;;
	*)
		echo "Invalid operation!"
		exit 3
		;;
esac
