#!/bin/bash

## sbatch directives for Slurm scheduler

#SBATCH --account=aoml-hafs1
#SBATCH --job-name="testforecast"
#SBATCH -n 32
#SBATCH --tasks-per-node=2
#SBATCH --cpus-per-task=2
#SBATCH -o testforecast.%j.log
#SBATCH -e testforecast.%j.err
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

module list

# include settings for forecase program
. settings_sys.sh
. ${WORKhafs}/settings_grid.sh
. ${WORKhafs}/settings_chgres.sh
. ${WORKhafs}/settings_forecast.sh

# run shell script to set-up and run the forecast executable
./run_forecast_single.sh

