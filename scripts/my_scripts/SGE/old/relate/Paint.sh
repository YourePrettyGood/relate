#!/bin/bash

#$ -cwd -V
#$ -j y
#$ -P myers.prjc -q short.qc

echo "***********************************************"
echo "SGE job ID: "$JOB_ID
echo "SGE task ID: "$SGE_TASK_ID
echo "Run on host: "`hostname`
echo "Operating system: "`uname -s`
echo "Username: "`whoami`
echo "Started at: "`date`
echo "***********************************************"

#### function to check if data exists
check_file_existence (){
  if [ ! -f $1 ]; then
      echo "File " + $1 + " not found!"
      exit 1
  fi
}

mkdir -p results_c${chunk}
mkdir -p results_c${chunk}/paint

pushd results_c${chunk} #change in to this directory

file_seq="../data/sequences_${chunk}.txt"
file_pos="../data/pos_${chunk}.txt"
file_rec="../data/recombination_rate_${chunk}.txt"

check_file_existence $file_seq
check_file_existence $file_pos
check_file_existence $file_rec

#prepare input files for relate
../bin/./Relate \
  --mode "PrepareFiles" \
  --seq $file_seq \
  --rec $file_rec \
  --pos $file_pos 2>> ../log/prepare_files_c${chunk}.log

## paint all sequences against each other
../bin/./Relate --mode "Paint" 2>> ../log/paint_c${chunk}.log

popd

echo "***********************************************"
echo "Finished at: "`date`
echo "***********************************************"
exit 0
