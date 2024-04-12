# Student Cluster Compeititon - Tutorial 4

## Table of Contents

- [Part 1 - Enviroment Modules with Lmod](#part-1---enviroment-modules-with-lmod)
  - [Installing Lmod](#installing-lmod)
  - [Using Lmod](#using-lmod)
  - [Adding modules to Lmod](#adding-modules-to-lmod)
- [Part 2 - High Performance LINPACK (HPL) Benchmark](#part-2---high-performance-linpack-hpl-benchmark)
  - [System Libraries](#system-libraries)
    - [Static Libraries](#static-libraries)
    - [Dynamic Libraries](#dynamic-libraries)
  - [Message Passing Interface (MPI)](#message-passing-interface-mpi)
  - [Installing HPL](#installing-hpl)
  - [Adding a Second Compute Node](#adding-a-second-compute-node)
  - [Optimising HPL](#optimising-hpl)
    - [Theoretical Peak Performance](#theoretical-peak-performance)
- [Part 3 - HPC Challenge](#part-3---hpc-challenge)

## Overview

Tutorial 4 demonstrates environment module manipulation and the compilation and optimisation of HPC benchmark software. This introduces the reader to the concepts of environment management and workspace sanity, as well as compilation of software on Linux.

In this tutorial you will:

- [ ] Install and configure Lmod on your head node.
- [ ] Download and compile the High Performance LINPACK (HPL) benchmark.
- [ ] Create Slurm batch scripts to submit jobs for your benchmark runs.
- [ ] Optimise HPL.
- [ ] Download and compile the High Performance Computing Challenge (HPCC) benchmark.

<div style="page-break-after: always;"></div>

## Part 1 - Enviroment Modules with Lmod

Environment Modules provide a convenient way to dynamically change a user's environment through _modulefiles_ to simplify software and library use when there are multiple versions of a particular software package (e.g. Python2.7 and Python 3.x) installed on the system. Environment Module parameters typically involve, among other things, modifying the PATH environment variable for locating a particular package (such as dynamically changing the path to Python from `/usr/local/bin/python2.7` to `/usr/local/bin/python3`).

Lmod is a Lua-based environment module tool for users to easily manipulate their HPC software environment and is used on thousands of HPC systems around the world.

### Installing Lmod

To install Lmod on **CentOS 8**, make sure that you have the **EPEL** repository enabled:

```bash
[...@headnode ~]$ sudo dnf install epel-release
```

This will enable additional software to be made available to the CentOS package manager. With this done, install the Lmod packages:

```bash
[...@headnode ~]$ sudo dnf --enablerepo=powertools install Lmod
```

Now log out and back into your session.

### Using Lmod

With Lmod installed, you'll now have some new commands on the terminal. Namely, these are: `module <subcommand>`. The important ones for you to know and use are: `module avail`, `module list`, `module load` and `module unload`. These commands do the following:

| Command                       | Operation                                            |
|-------------------------------|------------------------------------------------------|
| `module avail`                | Lists all modules that are available to the user.    |
| `module list`                 | Lists all modules that are loaded by the user.       |
| `module load <module_name>`   | Loads a module to the user's environment.            |
| `module unload <module_name>` | Removes a loaded module from the user's environment. |

Lmod also features a shortcut command `ml` which can perform all of the above commands:

| Command             | Operation                                        |
|-------------------- |--------------------------------------------------|
| `ml`                | Same as `module list`                            |
| `ml avail`          | Same as `module avail`                           |
| `ml <module_name>`  | Same as `module load <module_name>`              |
| `ml -<module_name>` | Same as `module unload <module_name>`            | 
| `ml foo`       | Same as `module load foo`                        | 
| `ml foo -bar`       | Same as `module load foo` and `module unload bar`|


### Adding modules to Lmod

Some installed packages will automatically add environment modules to the Lmod system, while others will not and will require you to manually add definitions for them. For example, the `openmpi` package that we will install with `dnf` later in this tutorial will automatically add a module file to the system for loading via Lmod.

We will detail how to create a module file for your own software later.

<div style="page-break-after: always;"></div>

## Part 2 - High Performance LINPACK (HPL) Benchmark

The High Performance LINPACK (HPL) benchmark is used to measure a system's floating point number processing power. The resulting score (in Floating Point Operations Per Second, or FLOPS for short) is often used to roughly quantify the computational power of an HPC system. HPL requires math libraries to perform its floating point operations as it does not include these by itself and it also requires an MPI installation for communication in order to execute in parallel across multiple CPU cores (and hosts).

### System Libraries

A library is a collection of pre-compiled code that provides functionality to other software. This allows the re-use of common code (such as math operations) and simplifies software development. You get two types of libraries on Linux: `static` and `dynamic` libraries.

#### Static Libraries

Static libraries are embedded into the binary that you create when you compile your software. In essence, it copies the library that exists on your computer into the executable that gets created at **compilation time**. This means that the resulting program binary is self-contained and can operate on multiple systems without them needing the libraries installed first. Static libraries are normally files that end with the `.a` extension, for "archive".

Advantages here are that the program can potentially be faster, as it has direct access to the required libraries without having to query the operating system first, but disadavanges include the file size being larger and updating the library requires recompiling (and linking the updated library) the software.

#### Dynamic Libraries

Dynamic libraries are loaded into a compiled program at **runtime**, meaning that the library that the program needs is **not** embedded into the executable program binary at compilation time. Dynamic libraries are files that normally end with the `.so` extension, for "shared object".

Advantages here are that the file size can be much smaller and the application doesn't need to be recompiled (linked) when using a different version of the library (as long as there weren't fundamental changes in the library). However, it requires the library to be installed and made available to the program on the operating system.

HPL uses dynamic libraries for its math and MPI communication, as mentioned above.

### Message Passing Interface (MPI)

MPI is a message-passing standard used for parallel software communication. It allows for software to send messages between multiple processes. These processes could be on the local computer (think multiple cores of a CPU or multiple CPUs) as well as on networked computers. MPI is a cornerstone of HPC. There are many implementations of MPI in software such as OpenMPI, MPICH, MVAPICH2 and so forth. To find out more about MPI, please read the following: [https://www.linuxtoday.com/blog/mpi-in-thirty-minutes.html](https://www.linuxtoday.com/blog/mpi-in-thirty-minutes.html)

### Installing HPL

We need to install the dynamic libraries that HPL expects to have, as well as the software for MPI. The MPI implementation we're going to use here is OpenMPI and we will use the Automatically Tuned Linear Algebra Software (ATLAS) math library.

**Remember, since it's dynamically linked, we need to ensure that ALL of our nodes that we expect to run the software on have the expected libraries.**

1. Install OpenMPI and ATLAS and their libraries on all of your nodes:

    ```bash
    [...@headnode ~]$ sudo dnf install openmpi atlas openmpi-devel atlas-devel
    ```

    ```bash
    [...@computenode ~]$ sudo dnf install openmpi atlas openmpi-devel atlas-devel
    ```

2. On the head node, in your NFS-shared home directory, download and extract the latest HPL release from the following URL:

    ```http
    http://www.netlib.org/benchmark/hpl/
    ```

3. Extract the downloaded file using `tar`.

4. Enter the extracted directory. In this directory there is a directory called `setup`, which contains templates for settings for compiling HPL with various computer hardware configurations. Pick one that is closest to your CPU architecture and copy it to the root HPL extracted directory. The `Make.Linux_PII_CBLAS_gm` file will do for your VMs.
    
    ```bash
    [...@headnode ~]$ cd hpl-<version>
    [...@headnode hpl-<version>]$ cp setup/Make.Linux_PII_CBLAS_gm .
    ```

    **NOTE:** The Makefile suffix (`Linux_PII_CBLAS_gm` in this case) is used as the architecture identifier and is required to be specified when building the software later. The period `.` indicates that we are working in the current directory.

4. Edit the `Make.Linux_PII_CBLAS_gm` file and change the following line to represent where your extracted `hpl-<version>` directory is (you can use `pwd` while inside of the directory to get the full path):

    ```conf
    TOPdir = </path/to/extracted/hpl/directory>
    ```

5. In `Make.Linux_PII_CBLAS_gm`, edit the following lines to specify where your dynamic libraries are for ATLAS:

    ```conf
    LAdir        = /usr/lib64/atlas
    LAlib        = $(LAdir)/libtatlas.so $(LAdir)/libsatlas.so
    ```

6. In `Make.Linux_PII_CBLAS_gm`, edit the following lines to specify which binaries you want to use for your C compiler and linker. We want to use the compiler included with OpenMPI, which is called `mpicc` (MPI C Compiler):

    ```conf
    CC           = mpicc
    LINKER       = mpicc
    ```

    > **! >>> By default, the OpenMPI you installed above is not available in your environment ($PATH & $LD_LIBRARY_PATH). Make OpenMPI available BEFORE you do any compilation steps below. To load it, do a `module avail` and look for the `mpi` module and then `module load` that module.**

7. Compile HPL

    **Important tip**: if your compile fails, you should reset to a clean start point with `make clean`.

    ```bash
    [...@headnode ~]$ make arch=<arch> #<arch> in this case is Linux_PII_CBLAS_gm
    ```

    To confirm that the compilation completed successfully, check that the `xhpl` executable was produced in `<hpl_extracted_dir>/bin/<arch>/xhpl`.

8. The `HPL.dat` file (in the same directory as `xhpl`) defines how the HPL benchmark solves a large dense linear array of **double precision floating point numbers**. Therefore, selecting the appropriate parameters in this file can have a massive effect on the FLOPS you obtain.

    ```
         The most important parameters are:
    N:   defines the length of one of the sides of the 2D array to be solved. 
         Therefore, problem size ∝ runtime ∝ memory usage ∝ <N>². 
         For best performance N should be a multiple of NB.
    NB:  defines the block (or chunk) size into which the array is divided. 
         The optimal value is determined by the CPU architecture such that the block fits in cache (Google). 
    P&Q: define the domains (in two dimensions) for how the array is partitioned on a distributed memory system. 
         Therefore P*Q = MPI ranks.  
    ```

    You can find online calculators that will generate an `HPL.dat` file for you **as a starting point**, but you will still need to do some tuning if you want to squeeze out maximum performance.

9. Execute HPL on your head node

    ```bash
    [...@headnode ~]$ mpirun -np <cores> ./xhpl
    ```

10. Create a SLURM submission script to run your benchmark on your compute node. The script should look as follows:

    ```bash
    #!/bin/bash 
    #SBATCH --ntasks <MPI_RANKS>
    #SBATCH -N <NODES>
    #SBATCH -t 02:00:00
    #SBATCH --export=ALL
    #SBATCH --job-name=hpl_benchmark
    
    mpirun /path/to/xhpl
    ```

    SLURM will populate the appropriate MPI parameters based on the resources you requested, so specifying ranks (-np) is not required.

11. Make sure your MPI environment is loaded, and then submit your job to SLURM:

    ```bash
    [...@headnode ~]$ sbatch <script>
    ```

12. Check the state of your job with

    ```bash
    [...@headnode ~]$ squeue
    ```

    By default, SLURM will store the job output to a log file `slurm-<job_id>.out`, on the compute node (Slurm writes the output file on the first node that the job has been allocated to by default). Since your home directory is shared via NFS, you should be able to check the output on any of your nodes.

### Adding a Second Compute Node

At this point you are ready to run HPL on your cluster with two compute nodes. It's time to deploy a second compute node in OpenStack.

<span style="color: #800000">
  !!! Have the output **log file** `slurm-<job_id>.out` AND `Make.<architecture>` **configuration file** ready for instructors to view on request.
</span>



Pay careful attention to the hostname, network and other configuration settings that may be specific to and may conflict with your initial node. Once your two compute nodes have been successfully deployed, are accessible from the head node and added to SLURM, you can continue with running HPL across multiple nodes.

As a sanity check repeat Steps 10-12 of the previous task: [Message Passing Interface (MPI)](#message-passing-interface-mpi), but this time do it for **two** compute nodes and check the new results of your benchmark.

### Optimising HPL

You now have a functioning HPL benchmark and a compute cluster. However, using math libraries (BLAS, LAPACK, **ATLAS**) from a repository (`dnf`) **will not yield optimum performance**, because these repositories **contain generic code compiled to work on all x86 hardware**.

Code compiled specifically for HPC hardware can use instruction sets like **AVX**, **AVX2** and **AVX512** (if available) to make better use of the CPU. A (much) higher HPL result is possible if you compile your math library (such as ATLAS, GOTOBLAS, OpenBLAS or Intel MKL) from source code on the hardware you intend to run the code on.

The VMs that make up your cluster are not necessarily the same architecture, since they run on a variety of hardware in the ACE Lab. In order to compile high performance codes for your compute nodes, you need to perform the following steps on your compute nodes:

1. Download a math library's source code and compile it.

2. Recompile HPL using this new library implementation (edit `LAdir` in the `Makefile`). This has to be done for the target machines that you intend to run HPL on (think: NOT just the head node, since that just schedules the jobs to be run).

3. Re-run HPL on your cluster.

#### Theoretical Peak Performance

It is useful to know what the theoretical FLOPS performance (RPeak) of your hardware is when trying to obtain the highest benchmark result (RMax). RPeak can be derived from the formula:

```math
RPeak = CPU Frequency [GHz] * Num CPU Cores * OPS/cycle
```

Newer CPU architectures allow for 'wider' instruction sets which execute multiple instructions per CPU cycle. The table below shows the floating point operations per cycle of various instruction sets:


| CPU Extension | Floating Point Operations per CPU Cycle |
|---------------|-----------------------------------------|
| SSE4.2        | 4                                       |
| AVX           | 8                                       |
| AVX2          | 16                                      |
| AVX512        | 32                                      |


You can determine your CPU model as well as the instruction extensions supported on your **compute node(s)** with the command:

```bash
[...@computenode ~]$ cat /proc/cpuinfo | grep -Ei "processor|model name|flags"
```

For model name, you should see something like "... Intel Xeon E5-26.....". If instead you see "QEMU...", please notify the course Instructors to assist you.

You can determine the maximum and base frequency of your CPU model on the Intel Ark website. Because HPL is a demanding workload, assume the CPU is operating at its base frequency and **NOT** the boost/turbo frequency. You should have everything you need to calculate the RPeak of your cluster. Typically an efficiency of at least 75% is considered adequate for Intel CPUs (RMax / RPeak > 0.75).

## Part 3 - HPC Challenge

HPC Challenge (or HPCC) is benchmark suite which contains 7 micro-benchmarks used to test various performance aspects of your cluster. HPCC includes HPL which it uses to access FLOPs performance. Having successfully compiled and executed HPL, the process is fairly straight forward to setup HPCC (it uses the same Makefile structure).

1. Download HPCC from https://icl.utk.edu/hpcc/software/index.html

2. Extract the file, then enter the `hpl/` sub-directory.

3. Copy and modify the Makefile as your did for the HPL benchmark, but in this case also add "-std=c99" to the "CCFLAGS" line in the Makefile.

4. Compile HPCC from the base directory using

    ```bash
    make arch=<arch>
    ```

5. Edit the `hpccinf.txt` file (same as `HPL.dat`)

6. HPCC replies on the input parameter file 'hpccinf.txt' (same as `HPL.dat`). Run HPCC as you did HPL.

7. Download this script which formats the output into a readable format [https://tinyurl.com/y65p2vv5](https://tinyurl.com/y65p2vv5).

8. Install `perl` on your head node through `dnf`.

8. Run the script with

    ```bash
    ./format.pl -w -f hpccoutf.txt
    ```

    To see your benchmark result, your HPL score should be similar to your standalone HPL. 

<span style="color: #800000">
  !!! Have the output `hpccoutf.txt` AND `Make.<architecture>` **configuration file** ready for instructors to view on request.
</span>
# Student Cluster Compeititon - Tutorial 5

## Table of Contents

- [Overview](#overview)
- [GROMACS Application Benchmark](#gromacs-application-benchmark)
  - [Part 1: Installation](#part-1---installation)
  - [Part 2: Benchmark](#part-2---benchmark)
    - [Benchmark 1 (adh_cubic):](#benchmark-1-adh_cubic)
    - [Benchmark 2 (1.5M_water):](#benchmark-2-15m_water)
  - [Part 3: Protein Visualisation](#part-3-protein-visualisation)

## Overview

Tutorial 5 has you compile the GROMACS scientific software. You will then run the software on data sets that are provided to you and upload the results.

In this tutorial you will:

- [ ] Download, install and compile the GROMACS benchmark.
- [ ] Run the GROMACS benchmark on sample data sets.
- [ ] Visualise the output from your GROMACS runs on your local computer.

<div style="page-break-after: always;"></div>

## GROMACS Application Benchmark

GROMACS is a versatile package to perform molecular dynamics, i.e. simulate the Newtonian equations of motion for systems with hundreds to millions of particles. It is primarily designed for biochemical molecules like proteins, lipids and nucleic acids that have a lot of complicated bonded interactions, but since GROMACS is extremely fast at calculating the nonbonded interactions (that usually dominate simulations) many groups are also using it for research on non-biological systems, such as polymers.

The files required for this tutorial can be found on the ACE Lab SSH server (ssh.ace.chpc.ac.za) under the `/apps/gromacs` folder. The archive name should be `gromacs_benchmarks.tar.gz`.

### Part 1: Installation

Detailed installation instructions can be found at: http://manual.gromacs.org/current/install-guide/index.html, but here's a general installation overview:

1. Ensure you have an up-to-date `cmake` available on your system.

2. You will also require a compiler such as the GNU `gcc`, Intel `icc` or other, and **MPI (OpenMPI, MPICH, Intel MPI or other)** be installed on system. Your **PATH** & **LD_LIBRARY_PATH** environment variables should be set up to reflect this.

3. Compile GROMACS **with MPI support** from source using `cmake`. 

<div style="page-break-after: always;"></div>

### Part 2: Benchmark

You have been provided two **GROMACS** benchmarks. The first benchmark **(adh_cubic)** should complete within a few minutes and has a small memory footprint, it is intended to demonstrate that your installation is working properly. The second benchmark **(1.5M_water)** uses more memory and takes considerably longer to complete. The metric which will be used to assess your performance is the **ns/day** (number of nanoseconds the model is simulated for per day of computation), quoted at the end of the simulation output. **Higher is better**. 

#### Benchmark 1 (adh_cubic):

Ensure that your GROMACS /**bin** directory is exported to your **PATH**. You should be able to type `gmx_mpi --version` in your terminal and have the application information displayed correctly. The first task is to pre-process the input data into a usable format, using the `grompp` tool:

```bash
[...@node ~]$ gmx_mpi grompp -f pme_verlet.mdp -c conf.gro -p topol.top -o md_0_1.tpr
```

You will need to prepare a **Slurm batch script**, `gromacs_mpi.sh`. Modify the variables to appropriate values.

```bash
#!/bin/bash
#SBATCH --nodes=XXXX
#SBATCH --ntasks-per-node=XXXX
#SBATCH --cpus-per-task=XXXX

# !!!! Depending on your environment configuration, uncomment or add the following
# --------------------------------------------------------------------------------
#module load gromacs
#ml load gromacs
#export PATH and LD_LIBRARY_PATH
mpirun gmx_mpi mdrun -nsteps 5000 -s md_0_1.tpr -g gromacs.log
```

Then execute the script from you head node, which will in turn launch the simulation using MPI and write output to the log file `gromacs_log`.

You may modify the `mpirun` command to optimise performance (significantly) but in order to produce a valid result, the simulation must run for **5,000 steps**. Quoted in the output as:

```text
"5000 steps,     10.0 ps."
```

<span style="color: #800000">
  !!! Please be able to present the instructors with the output of `gmx_mpi --version`. Also be able to present the instructors with your Slurm batch script and `gromacs_log` files for the **adh_cubic** benchmark.
</span>

#### Benchmark 2 (1.5M_water):

Pre-process the input data using the `grompp` command

```bash
[...@node ~]$ gmx_mpi grompp -f pme_verlet.mdp -c out.gro -p topol.top -o md_0_1.tpr
```

Using a batch script similar to the one above, run the benchmark. You may modify the mpirun command to optimise performance (significantly) but in order to produce a valid result, the simulation must run for 5,000 steps. Quoted in the output as:

```text
"5000 steps,     10.0 ps."
```

<span style="color: #800000">
  !!! Please be ready to present the `gromacs_log` files for the **1.5M_water** benchmark to the instructors.
</span>


### Part 3: Protein Visualisation

> **! >>> You will need to work on your personal computer (or laptop) to complete this section.**

You are able to score bonus points for this tutorial by submitting a visualisation of your **adh_cubic** benchmark run. Follow the instructions below to accomplish this and upload the visualisation.

Download and install the VMD visualization tool by selecting the correct version for your operating system. For example, for a Windows machine with an Nvidia GPU select the “Windows OpenGL, CUDA” option. You may need to register on the website.

```http
https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD
```

Use the `WinSCP` application for Windows, or the `scp` command for Linux to copy the output file `confout.gro` of the **adh_cubic** benchmark from your cluster to your PC. Attempting to visualise the larger "1.5M_water" simulation is not necessary and not recommended due to memory limitations of most PCs.

1. Open VMD, select **File** then **New Module...**, click **Browse...** and select your `.gro` file.

2. Ensure the filetype was detected as **Gromacs GRO** then click **Load**. In the main VMD window you will see that 134177 particles have been loaded. You should also see the display window has been populated with your simulation particle data.

    You can manipulate the data with your mouse cursor: zoom with the mouse wheel or rotate it by dragging with the left mouse button held down. This visualisation presents a naturally occurring protein (blue/green) found in the human body, suspended in a solution of water molecules (red/white).

3. From the main VMD window, select **Graphics** then **Representations..**.

4. Under **Selected Atoms**, replace **all** with **not resname SOL** and click **apply**. You will notice the water solution around your protein has been removed, allowing you to better examine the protein.

5. In the same window, select the dropdown **Drawing Method** and try out a few different options. Select **New Cartoon** before moving on.

6. From the main VMD window, once again select **Graphics** then **Colors**. Under **Categories**, select **Display**, then **Background**, followed by **8 white**.

7. Finally, you are ready to render a snapshot of your visualisation. From the main window, select **File** then **Render...**, ensure **Snapshot...** is selected and enter an appropriate filename. Click **Start Rendering**.

Simulations like this are used to to develop and prototype experimental pharmaceutical drug designs. By visualising the output, researchers are able to better interpret simulation results.

<span style="color: #800000">
  > Copy the resulting `.bmp` file(s) from yout cluster to your local computer or laptop and demonstrate this to your instructors for bonus points.
</span>
