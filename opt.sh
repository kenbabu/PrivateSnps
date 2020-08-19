#!/bin/bash


if (( $# == 0)); then
	echo "Please pass arguments  -d <directory> -o <output_file>"
	exit 2
fi

echo "$# arguments found!"

while getopts ":d:o" opt; do
	case  $opt in
		d)
		echo "Directory passed: $OPTARG" >&2
			;;
		o)
			echo "Output file passed: $OPTARG" >&2
				;;
		\?)
			echo "Invalid option: $OPTARG" >&2
				;;
		:)
			echo "Option  -$OPTARG requires an argument" >&2
			exit 1
				;;
	esac
done
