#!/bin/bash

echo "================================";
echo "PROCESS FILE LIST";
echo "================================";

INPUT_DIR=$1
COUNTER=0
PROCESSED_FILES="PROCESSED_FILES.TXT"

LOGFILE="annotate_snpeff.log"

touch $PROCESSED_FILES

OUTPUT_DIR=$2

if [ ! -d "$OUTPUT_DIR" ] && mkdir -p "./SNPEFF_ANNOTATIONS"; then
	OUTPUT_DIR='./SNPEFF_ANNOTATIONS'
	echo "Created output directory"

fi


if [ "$(ls -A $OUTPUT_DIR)" ]; then
     echo "Clearing the  contents of $OUTPUT_DIR"
     rm -rf $OUTPUT_DIR/*
else
    echo "$OUTPUT_DIR is Empty"
fi


for file in $INPUT_DIR/*.gz; do
	FILEPATH=$(realpath $file)
	COUNTER=$((COUNTER+1))

	if  grep -Fxq "$FILEPATH" filelist.txt 
	then
    	echo "Found: $FILEPATH"

    	POP_FILE=$(echo $FILEPATH | cut -d '/' -f8 | cut -d '.' -f1 )

    	start_time=`date +%s`

    	java -Xmx4G -jar $snpEff -v GRCh37.75  $FILEPATH > $OUTPUT_DIR/$POP_FILE.ann.vcf
		bgzip $OUTPUT_DIR/$POP_FILE.ann.vcf
		tabix -h $OUTPUT_DIR/$POP_FILE.ann.vcf.gz
    	# echo "$POP_FILE"

    	end_time=`date +%s`
		TIME_DIFF=`expr $end_time - $start_time`

		printf "Processed $POP_FILE in $TIME_DIFF seconds\n">>$LOGFILE

		printf "$FILEPATH\n" >> $PROCESSED_FILES

	else
		echo "Not found $FILEPATH" 
    # code if not found
	fi
	
done

printf "Counted $COUNTER  files!\n"


