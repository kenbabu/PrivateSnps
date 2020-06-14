#!/bin/bash

echo "-----------------";
echo "Find private SNPS";
echo "=================";

BCF_DIR=$1
OUT_DIR=$2

# Define populations
POP1="ACB"
POP2="ASW"
POP3="ESN"
POP4="GWD"
POP5="LWK"
POP6="MSL"
POP7="YRI"

# LOG FILE
LOGFILE="$OUT_DIR/popgen.log"
touch $LOGFILE

for i in {1..22};
	do
		# echo "Chromosome $i";
		# Create chromosome directory if it doesn't exist
		if [ ! -d "${OUT_DIR}/chr${i}" ]; then
			echo "Creating $OUT_DIR/chr$i"
			echo `mkdir $OUT_DIR/chr${i} `
		fi
		# Time execution of command
		start_time=`date +%s`
		echo "bcftools isec $BCF_DIR/${POP1}_chr$i.vcf.gz  $BCF_DIR/${POP1}_chr$i.vcf.gz  $BCF_DIR/${POP2}_chr$i.vcf.gz \
		 		$BCF_DIR/${POP3}_chr$i.vcf.gz  $BCF_DIR/${POP4}_chr$i.vcf.gz" \
				" $BCF_DIR/${POP5}_chr$i.vcf.gz  $BCF_DIR/${POP6}_chr$i.vcf.gz  $BCF_DIR/${POP7}_chr$i.vcf.gz " \
				" -p ${OUT_DIR}/chr${i} -n -1 -c all"
		sleep 2
		end_time=`date +%s`
		# echo
		echo "Processed chr$i in  `expr $end_time - $start_time` seconds" >> $LOGFILE;
		#echo " bcftools isec ACB_chr21.vcf.gz ASW_chr21.vcf.gz ESN_chr21.vcf.gz GWD_chr21.vcf.gz LWK_chr21.vcf.gz MSL_chr21.vcf.gz YRI_chr21.vcf.gz -p ~/Desktop/VCFExamples/chr21  -n -1 -c all"

	done

