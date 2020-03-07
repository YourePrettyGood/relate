#!/bin/bash

#$ -V
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

../bin/./Relate \
  --mode "FindEquivalentBranches" \
  --seq "../data/sequences_${chunk}.txt" \
  -o ${output} 2>> ../log/find_equivalent_branches_c${chunk}.log

echo "***********************************************"
echo "Finished at: "`date`
echo "***********************************************"
exit 0
