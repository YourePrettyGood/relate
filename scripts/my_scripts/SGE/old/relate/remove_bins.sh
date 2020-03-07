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

mkdir -p delete_tmp
rsync -a --delete delete_tmp/ paint/
rmdir paint

echo "***********************************************"
echo "Finished at: "`date`
echo "***********************************************"
exit 0