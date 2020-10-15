#!/bin/bash

echo "================================";
echo "CREATE FILE PATHS ";
echo "================================";


INPUT_DIR=$1
FILELIST="filelist.txt"
touch $FILELIST

for file in $INPUT_DIR/*.gz; do
	FILEPATH=$(realpath $file)
	printf "$FILEPATH\n" >> $FILELIST
done

#  Process each file in filelist

while IFS= read -r line; do
	echo "working on $line ..."
	zcat $line | bcftools  query -f '%CHROM\t%ID\n' | head
done <"${FILELIST}"