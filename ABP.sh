#!/bin/bash

# these commands load the proper env for snakemake and the pipeline
module purge
. /etc/profile.d/modules.sh
module load modules modules-init modules-gs/prod modules-eichler
module load anaconda/20161130
#base2="/net/eichler/vol21/projects/bac_assembly/nobackups/scripts"
base2="/net/eichler/vol2/home/mvollger/projects/abp"


NPROC=$(nproc)

regionsDir=$1
pushd $regionsDir
 


# these are the outputs of snakefiles, by getting rid of them I ensure that is checks that 
# all the tasks have been done
rm -f PSV1_done PSV2_done


# sometimes snakemake fails in a really bad way and it leaves to lock on the dir
# this is probably bad practive but oh well
if [ "unlock" == "unlock" ]; then
    snakemake --unlock -s $base2/ABP1.py
    snakemake --unlock -s $base2/ABP2.py
fi


#
# One of the programs I use (whatshap) requires a bunch of things, and I made a conda env
# to handle those things, but I have to check to see if you have it installed
# this should no longer be nessisary, whatshap is installed in one of our modules
# 
if [ -d $HOME/.conda/envs/whatshap ]; then
     echo "conda env exists, continuing"
else
    echo "whatshap does not exist, installing, may take some time"
    conda env create -f $base2/whatshap.env.yml
fi


# run the pipeline
if [ "$1" == "PSV1" ]; then
    # creats the partitioned groups from reads.orin.bam ref.fasta, and duplicaitons.fasta
    snakemake -p -s $base2/ABP1.py
elif [ "$1" == "PSV2" ]; then
    # creats the assemblies from the output of PSV1.py
    snakemake -p -s $base2/ABP2.py
else
    echo "Running PSV1 and PSV2"
    snakemake -p --cores $NPROC -s $base2/ABP1.py && snakemake -p --cores $NPROC -s $base2/ABP2.py 
    popd
fi 



