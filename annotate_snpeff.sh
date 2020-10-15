#!/bin/bash

echo "================================";
echo "Annotate VCF files with snpEff  ";
echo "================================";

# Initialize log files
LOGFILE="annotate_snpeff.log"
touch $LOGFILE

# READ VCF files from an input directory

INPUT_DIR=$1;

if [ ! -d "$INPUT_DIR" ]; then

	echo "No valid input directory found!\nThe program will exit.."
	exit 1;

fi

OUTPUT_DIR=$2

if [ ! -d "$OUTPUT_DIR" ] && mkdir -p "./SNPEFF_ANNOTATIONS"; then
	OUTPUT_DIR='./SNPEFF_ANNOTATIONS'
	echo "Created output directory"

fi

echo "Outputs are stored in: $OUTPUT_DIR"

COUNTER=0
# Change to process a few files to test the  script
STOPNUM=1000

# Clear output directory
# [ "$(ls -A  $OUTPUT_DIR/)" ] && echo "Not Empty" || echo "Empty"

if [ "$(ls -A $OUTPUT_DIR)" ]; then
     echo "Clearing the  contents of $OUTPUT_DIR"
     rm -rf $OUTPUT_DIR/*
else
    echo "$OUTPUT_DIR is Empty"
fi

START_TIMESTAMP=`date +%T`

printf "$START_TIMESTAMP:\tStarting to process files in the $INPUT_DIR directory\n">>$LOGFILE

for file in $INPUT_DIR/*.vcf.gz; do
	COUNTER=$((COUNTER+1))

	if [ $COUNTER -gt $STOPNUM ]; then
		exit 1
	fi
	start_time=`date +%s`
	
	ANNOT_FILE=$(echo $file | cut -d '/' -f3 | cut -d '.' -f1)

	printf "Formatted filename: $ANNOT_FILE\n">>$LOGFILE

	java -Xmx4G -jar $snpEff -v GRCh37.75  $file > $OUTPUT_DIR/$ANNOT_FILE.ann.vcf
	bgzip $OUTPUT_DIR/$ANNOT_FILE.ann.vcf
	tabix -h $OUTPUT_DIR/$ANNOT_FILE.ann.vcf.gz

	# $(echo $CMD_STR)
	# OUTPUT_FILE=$(echo $file | cut -d '/' -f7 | cut -d '.' -f2 )


	

	# touch $OUTPUT_DIR/$ANNOT_FILE.vcf
	
	# bcftools query -f '%CHROM\t%ID\t%AF\n' $file | head 
	
	end_time=`date +%s`
	TIME_DIFF=`expr $end_time - $start_time`

	echo "Executed in $end_time - $start_time: $TIME_DIFF seconds";
	printf "Processed $ANNOT_FILE in $TIME_DIFF seconds">>$LOGFILE

done

END_TIMESTAMP=`date +%T`
printf "$END_TIMESTAMP:\tEnded processing files in the $INPUT_DIR directory\nOutput stored in $OUTPUT_DIR\n">>$LOGFILE


#  Create an output directory if it doesnt exist


#  

#  For each file annotate the file 

#  Save the annotated file in the output directory

# 