#!/bin/bash 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR
module purge                                                                    
module load modules modules-init modules-gs modules-eichler
module load python/2.7.3
module load numpy/1.11.0
module load cython/0.25.2
module load hdf5/1.8.13
module load h5py/2.4.0
 


export HDF5LIBDIR=/net/eichler/vol5/home/mchaisso/software/hdf/lib
export HDF5INCLUDEDIR=/net/eichler/vol5/home/mchaisso/software/hdf/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HDF5LIBDIR

export PYTHONPATH=$PYTHONPATH:/net/eichler/vol5/home/mchaisso/software/quiver/lib/python2.7/site-packages/
export PATH=$PATH:$DIR
# added DG 5/19/2016
export PYTHONPATH=$PYTHONPATH:/net/gs/vol1/home/dgordon/python/functools32/python-functools32/install/lib/python2.7/site-packages/