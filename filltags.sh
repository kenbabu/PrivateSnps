#!/bin/bash

declare -a POPS=("ACB" "ASW" "ESN" "GWD" "LWK" "MSL" "YRI")

DATA_DIR='./filltered'


for file in $DATA_DIR/*.gz; do
	OUTPUT_FILE=$(echo $file | sed 's/_filltered//'| cut -d '/' -f3 )
	echo $OUTPUT_FILE

	#  Create filltags
	start_time=`date +%s`
	bcftools +fill-tags $file  -Oz -o AlleleFreqs/$OUTPUT_FILE -- -t AF,AC,AN,MAF,NS
	end_time=`date +%s`
	echo

	echo "=================================================================="
	echo "Processed $OUTPUT_FILE in  `expr $end_time - $start_time` seconds"
	echo "=================================================================="
done