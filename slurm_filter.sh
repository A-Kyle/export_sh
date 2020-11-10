#!/bin/bash

## sbatch directives for Slurm scheduler

#SBATCH --account=aoml-hafs1
#SBATCH --job-name="testfilter"
#SBATCH -n 1
#SBATCH --tasks-per-node=6
#SBATCH --cpus-per-task=6
#SBATCH -o testfilter.%j.log
#SBATCH -e testfilter.%j.err
#SBATCH -t 00:30:00
#SBATCH --exclusive

set -ax
ulimit -s unlimited
ulimit -a

module purge

module load cmake/3.15.4
module load intel/2020
module load impi/2020

module use -a /apps/contrib/NCEPLIBS/orion/modulefiles
module load w3nco/2.1.0
module load nemsio/2.3.0
module load bacio/2.2.0
module load sp/2.1.0
module load sfcio/1.2.0
module load sigio/2.2.0
module load gfsio/1.2.0
module load w3emc/2.5.0
module load ip/3.1.0
module load nemsiogfs/2.3.0
module load landsfcutil/2.2.0

# George V's version.
module use -a /apps/contrib/NCEPLIBS/lib/modulefiles
module load g2-intel-sandybridge/2.5.0

export Jasper_ROOT="/apps/jasper-1.900.1"

module load netcdf/4.7.2-parallel
#module load esmf/8.0.0_ParallelNetCDF
module load esmflocal/8.1.0.19bs

export WGRIB2_ROOT="/work/noaa/da/ggayno/save/wgrib2"

module list

# include settings for grid generation
. settings_sys.sh
. ${WORKhafs}/settings_grid.sh

./run_filtertopo.sh

