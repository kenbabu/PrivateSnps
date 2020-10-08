#!/bin/bash

echo "================================";
echo "Annotate VCF files with snpEff  ";
echo "================================";

# READ VCF files from an input directory

INPUT_DIR=$1;

if [ ! -d "$INPUT_DIR" ]; then

	echo "No valid input directory found!\nThe program will exit.."
	exit 1;


fi


#  Create an output directory if it doesnt exist

OUTPUT_DIR=$2

if [ ! -d "$OUTPUT_DIR" ] && mkdir -p "./SNPEFF_ANNOTATIONS"; then
	echo "Created output directory"

fi

#  

#  For each file annotate the file 

#  Save the annotated file in the output directory

# 