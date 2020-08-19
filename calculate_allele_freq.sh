#!/bin/bash



calc_freq_chr(){
	local chr;
	echo "Calculating frequency for chromosome: $chr ";
}

main(){

echo "==============================";
echo "Calculate Allele Frequencies  ";
echo "==============================";


if (( $# == 0)); then
	echo "Please pass arguments  -d <directory> -o <output_file>"
	exit 2
fi

while getopts ":d:o" opt; do
	case  $opt in
		d)
		echo "Directory passed: $OPTARG" >&2
			;;
		o)
			echo "Output file passed: $OPTARG" >&2
				;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
				;;
		:)
			echo "Option  -$OPTARG requires an argument" >&2
			exit 1
				;;
	esac
done

calc_freq_chr
# verbose='false'
# aflag='GIVE ME AN A'
# bflag=''
# files=''
# while getopts 'abf:v' flag; do
#   case "${flag}" in
#     a) aflag='true' ;;
#     b) bflag='true' ;;
#     f) files="${OPTARG}" ;;
#     v) verbose='true' ;;
#     *) error "Unexpected option ${flag}" ;;
#   esac
# done


# echo "There are ${#} parameters";	

}

main