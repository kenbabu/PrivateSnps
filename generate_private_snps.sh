#!/bin/bash

echo "======================";
echo "Generate Private SNPS";
echo "======================";

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

declare -a POPS=("ACB" "ASW" "ESN" "GWD" "LWK" "MSL" "YRI")
for i in {1..22};
	do
		# echo "Chromosome $i";
		# Create chromosome directory if it doesn't exist
		if [ ! -d "${OUT_DIR}/chr${i}" ]; then
			echo "Creating $OUT_DIR/chr$i"
			echo `mkdir $OUT_DIR/chr${i} `
		fi
		Time execution of command
		echo "Starting to process chr$1"
		start_time=`date +%s`
		for pop in "${POPS[@]}"; do
			echo "${pop}_chr$i"
			bcftools view ${BCF_DIR}/${pop}_chr$i.vcf.gz | vcftools --vcf - --max-missing 0.2 --maf 0.05 --recode --recode-INFO-all --stdout \
			| bcftools view -Oz -o  filltered/${pop}_chr${i}_filltered.vcf.gz

		done

		end_time=`date +%s`
		echo "=========================================================="
		echo "Processed chr$i in  `expr $end_time - $start_time` seconds"
		echo "=========================================================="
		

		
		# # sleep 2
		# echo " "
		# end_time=`date +%s`
		# # echo
		# echo "Processed chr$i in  `expr $end_time - $start_time` seconds" >> $LOGFILE;
		# #echo " bcftools isec ACB_chr21.vcf.gz ASW_chr21.vcf.gz ESN_chr21.vcf.gz GWD_chr21.vcf.gz LWK_chr21.vcf.gz MSL_chr21.vcf.gz YRI_chr21.vcf.gz -p ~/Desktop/VCFExamples/chr21  -n -1 -c all"

	done

#  Filter SNPS

# bcftools view LWK_chr21.vcf.gz | vcftools --vcf ---max-missing 0.2 --maf 0.05 --recode --recode-INFO-all -- stdout | bcftools view -Oz -o filtered/LWK_chr21_filltered.vcf.gz

# Calculate allele frequency
# bcftools +fill-tags YRI_chr21_filltered.vcf.gz  -Oz -o YRI_chr21.vcf.gz -- -t AF,AC,AN,MAF,NS

# Private snps
# bcftools isec ACB_chr21.vcf.gz LWK_chr21.vcf.gz GWD_chr21.vcf.gz YRI_chr21.vcf.gz -p comps -n-3 -c all