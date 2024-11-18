# Install dependencies

sudo dnf update
sudo dnf install wget g++ cmake -y

# Installing and setting up dependecies
# MPI
sudo dnf install openmpi openmpi-devel -y
export PATH=/usr/lib64/openmpi/bin:$PATH
source ~/.bashrc
which mpirun;which mpicc

# FFTW 3.x
wget http://www.fftw.org/fftw-3.3.10.tar.gz
tar -xvzf fftw-3.3.10.tar.gz
cd fftw-3.3.10
./configure --enable-shared --enable-threads 
	#SWIFT doesn't use parralel capability of FFTW, so no need to ./configure --enable-mpi
make;sudo make check;
sudo make install
sudo ldconfig
fftw-wisdom --version
export PATH=/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
source ~/.bashrc
#rm -rf $HOME/fftw-3.3.10.tar.gz	#clean-up
#rm -rf $HOME/fftw-3.3.10		#clean-up


# LAAMPS
# wget https://download.lammps.org/tars/lammps-29Aug2024_update1.tar.gz
# tar -xvzf lammps-29Aug2024_update1.tar.gz
# cd lammps-29Aug24
# https://download.lammps.org/tars/lammps-stable.tar.gz

# git clone -b stable https://github.com/lammps/lammps.git
# cd lammps/src
# cmake ../cmake -D BUILD_MPI=on -D BUILD_OMP=on -D CMAKE_C_COMPILER=gcc -D CMAKE_CXX_COMPILER=g++ -D MPI_C_COMPILER=mpicc -D MPI_CXX_COMPILER=mpicxx
# make -j$(nproc); make DESTDIR=/<path-to-install-dir> install


# cp lmp_serial ../bench
# cp lmp_mpi ../bench
# cd ../bech
# ./lmp_serial -in in.lj
# export OMP_NUM_THREADS=<num_threads>
# mpirun -np <num_procs> lmp_mpi -in in.lj
# Save the output for submission
# ./lmp_serial < in.rhodo > lmp_serial_rhodo.out
# mpirun -np <num_procs> lmp_mpi -in in.rhodo > lmp_mpi_rhodo.out
