#!/bin/bash

echo "===============================";
echo "Generate indexes for VCF files";
echo "===============================";


DATA_DIR=$1

for file in $DATA_DIR/*.vcf.gz; do
	echo "Indexing $file"
	echo $(bcftools index $file)
	echo "Finished indexing $file"
done