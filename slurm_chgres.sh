#!/bin/bash

## sbatch directives for Slurm scheduler

#SBATCH --account=aoml-hafs1
#SBATCH --job-name="testchgres"
#SBATCH -n 6
#SBATCH --tasks-per-node=6
#SBATCH --cpus-per-task=6
#SBATCH -o testchgres.%j.log
#SBATCH -e testchgres.%j.err
#SBATCH -t 00:30:00
#SBATCH --exclusive

set -ax
ulimit -s unlimited
ulimit -a

module purge

module load intel/2020
module load impi/2020
module load szip/2.1.1

#module load hdf5/1.10.5
#module load netcdf/4.7.2

module use /apps/contrib/NCEPLIBS/lib/modulefiles
module load netcdfp/4.7.4

module use /apps/contrib/NCEPLIBS/orion/modulefiles

#module load hdf5/1.10.1
#module load netcdf/4.5.0
#module load hdf5_parallel/1.12.0
#module load netcdf_parallel/4.7.5

module load jasper/1.900.2
module load png/1.2.44
module load z/1.2.6
module load g2/3.1.1
module load g2tmpl/1.6.0
module load w3emc/2.4.0
module load w3nco/2.0.7
module load sp/2.0.3
module load ip/3.0.2
#module load bufr/11.4.0 # hafs_tools.fd failed
module load bufr/11.2.0
module load bacio/2.0.3
module load sigio/2.2.0
module load sfcio/1.2.0
module load gfsio/1.2.0
module load nemsio/2.2.4
module load nemsiogfs/2.3.0
module load landsfcutil/2.2.0


module load crtm/2.3.0
module load prod_util/1.2.0
module load grib_util/1.2.0
#module load grib_util-intel-sandybridge/v1.1.1

module load wgrib/2.0.8
setenv WGRIB2 /apps/wgrib-2.0.8/wgrib2/wgrib2

#module use /apps/contrib/NCEPLIBS/lib/modulefiles
#module load esmflocal/8.0.0.para
#module use -a /apps/contrib/NCEPLIBS/lib/modulefiles
#module load esmflocal/8_0_0r

module load cmake/3.15.4
setenv CMAKE_C_COMPILER mpiicc
setenv CMAKE_CXX_COMPILER mpiicpc
setenv CMAKE_Fortran_COMPILER mpiifort
setenv CMAKE_Platform orion.intel

#module load contrib noaatools

module load rocoto/1.3.1

module load intelpython3/2020

module list

# include settings for chgres program
. settings_sys.sh
. ${WORKhafs}/settings_grid.sh
. ${WORKhafs}/settings_chgres.sh

# run shell script containing calls to grid-based executables
./run_chgres_ic.sh

