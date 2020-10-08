#!/bin/bash

echo "================================";
echo "Annotate VCF files with snpEff  ";
echo "================================";

# READ VCF files from an input directory
INPUT_DIR=$1

echo "INPUT DIRECTORY: $INPUT_DIR";

if [ ! -d "$INPUT_DIR" ]; then

	echo "No valid input directory ${INPUT_DIR} found!\nThe program will exit.."
	exit 1;
fi

for file in $INPUT_DIR/*.vcf.gz; do
		echo "$file";

done

#  Create an output directory if it doesnt exist

OUTPUT_DIR=$2

if [ ! -d "$OUTPUT_DIR" ] && mkdir -p "./SNPEFF_ANNOTATIONS"; then
	echo "Created output directory"

fi

#  

#  For each file annotate the file 

#  Save the annotated file in the output directory

# 