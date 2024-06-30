CHPC 2024 Student Cluster Competition
======================================

Welcome the **Center for High Performance Computing (CHPC)'s Student Cluster Competition (SCC)** - Team Selection Round. This round requires each team to build a **prototype multi-node compute cluster** within the National Integrated Cyber Infrastructure Systems (NICIS) **virtual compute cloud** (described below).

The goal of this document is to introduce you to the competition platform and familiarise you with some Linux and systems administration concepts. This competition provides you with a fixed set of virtual resources, that you will use to initialize a set a set of virtual machines instances based on your choice _or flavor_ of **

# Table of Contents

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->

1. [Structure of the Competition](#structure-of-the-competition)
    1. [Getting Help](#getting-help)
    1. [Timetable](#timetable)
    1. [Scoring](#scoring)
    1. [Instructions for Mentors](#instructions-for-mentors)
        1. [Hands-Off Rule *(You may not touch the keyboard)*](#hands-off-rule-you-may-not-touch-the-keyboard)
    1. [Cheat Sheet](#cheat-sheet)
1. [Deliverables](#deliverables)
    1. [Project](#project)
    1. [Technical Knowledge Assessment](#technical-knowledge-assessment)
1. [Links to Livestreams and Lecture Recordings](#links-to-livestreams-and-lecture-recordings)
    1. [Day 1 - Welcome, Introduction and Getting Started](#day-1---welcome-introduction-and-getting-started)
    1. [Day 2 - HPC Hardware, HPC Networking and Systems Administration](#day-2---hpc-hardware-hpc-networking-and-systems-administration)
    1. [Day 3 - Benchmarking, Compilation and Parallel Computing](#day-3---benchmarking-compilation-and-parallel-computing)
    1. [Day 4 - HPC Administration and Application Visualization](#day-4---hpc-administration-and-application-visualization)
    1. [Day 5 - Career Guidance](#day-5---career-guidance)
1. [Tutorial Glossary and Section Overview](#tutorial-glossary-and-section-overview)
    1. [Tutorial 1](#tutorial-1)
    1. [Tutorial 2](#tutorial-2)
    1. [Tutorial 3](#tutorial-3)
    1. [Tutorial 4](#tutorial-4)
1. [Contributing to the Project](#contributing-to-the-project)
    1. [Steps to follow when editing existing content](#steps-to-follow-when-editing-existing-content)
    1. [Syntax and Style](#syntax-and-style)
1. [Collaborating with your Team and Storing you Progress on GitHub](#collaborating-with-your-team-and-storing-you-progress-on-github)
    1. [Forking the Tutorials into Your Own Team's Private GitHub Repository](#forking-the-tutorials-into-your-own-teams-private-github-repository)
    1. [Editing the Git Markdown Files to Track Your Team's Progress](#editing-the-git-markdown-files-to-track-your-teams-progress)

<!-- markdown-toc end -->

# Structure of the Competition

## Getting Help

You are strongly encouraged to contribute and improve the project by [Opening and Participating in Discussions](https://github.com/chpc-tech-eval/chpc24-scc-nmu/discussions), [Raising, Addressing and Resolving Issues](https://github.com/chpc-tech-eval/chpc24-scc-nmu/issues).

> [!TIP] Active participation in the student discussions and issues is an easy way to separate yourself from the rest of the competition and make it easy for the instructors to notice you!

## Timetable

<p align="center"><img alt="Timetable." src="./CHPC_2024_SCC_Local_Selection_Round_Timetable.png" width=900 /></p>

## Scoring

| Component                      | Weight | Breakdown |
| :---                           | :---:  | :---:     |
|                                |        |           |
| Technical Knowledge Assessment |        |           |
| Tutorials                      |        |           |
| HPCC                           |        |           |
| LAMMPS                         |        |           |
|                                |        |           |

## Instructions for Mentors

The role of Mentors and Volunteers is to provide leadership and guidance for the student competitors participating in this year's Center for High Performance Computing 2024 Student Cluster Competition.

In preparing your teams for the competition, your main goal is to ensure that you teach and impart knowledge to the student participants in such a way that they are empowered and enable to tackle the problems and benchmarking tasks themselves.

### Hands-Off Rule *(You may not touch the keyboard)*

Under no circumstances whatsoever may mentors touch any competition hardware belonging to either their team, or the competition hardware of another team. Mentors are encouraged to provide guidance and leadership to their *(as well as other)* teams.

Any mentors found to be directly in contravention of this rule, may result in their team incurring a penalty. Repeated infringements may result in possible disqualification of their team.

## Cheat Sheet

Below is a table with a number of Linux system commands and utilities that you *may* find useful in assisting you to debug problems that you may encounter with your clusters. Note that some of these utilities do not ship with the base deployment of a number of Linux flavors, and you may be required to install the associated packages, prior to making use of them.

| Command            | Description                                                                                                                                                                                                        |
| ---                | ---                                                                                                                                                                                                                |
| ssh                | Used from logging into the remote machine and for executing commands on the remote machine.                                                                                                                        |
| scp                | SCP copies files between hosts on a network. It uses ssh for data transfer, and uses the same authentication and provides the same security as ssh.                                                                |
| wget / curl        | Utility for non-interactive download of files from the Web.It supports HTTP, HTTPS, and FTP protocols.                                                                                                             |
| top / htop / btop  | Provides a dynamic real-time view of a running system. It can display system summary information as well as a list of processes or threads.                                                                        |
| screen / tmux      | Full-screen window manager that multiplexes a physical terminal between several processes (typically interactive shells).                                                                                          |
| ip a               | Display IP Addresses and property information                                                                                                                                                                      |
| dmesg              | Prints the message buffer of the kernel. The output of this command typically contains the messages produced by the device drivers                                                                                 |
| watch              | Execute a program periodically, showing output fullscreen.                                                                                                                                                         |
| df -h              | Report file system disk space usage.                                                                                                                                                                               |
| ping               | PING command is used to verify that a device can communicate with another on a network.                                                                                                                            |
| lynx               | Command-line based web browser (more useful than you think)                                                                                                                                                        |
| ctrl+alt+[F1...F6] | Open another shell session (multiple ‘desktops’)                                                                                                                                                                   |
| ctrl+z             | Move command to background (useful with ‘bg’)                                                                                                                                                                      |
| du -h              | Summarize disk usage of each FILE, recursively for directories.                                                                                                                                                    |
| lscpu              | Command line utility that provides system CPU related information.                                                                                                                                                 |
| lstotp             | View the topology of a Linux system.                                                                                                                                                                               |
| inxi               | Lists information related to your systems' sensors, partitions, drives, networking, audio, graphics, CPU, system, etc...                                                                                           |
| hwinfo             | Hardware probing utility that provides detailed info about various components.                                                                                                                                     |
| lshw               | Hardware probing utility that provides detailed info about various components.                                                                                                                                     |
| proc               | Information and control center of the kernel, providing a communications channel between kernel space and user space. Many of the preceding commands query information provided by proc, i.e. `cat /proc/cpuinfo`. |
| uname              | Useful for determining information about your current flavor and distribution of your operating system and its version.                                                                                            |
| lsblk              | Provides information about block devices (disks, hard drives, flash drives, etc) connected to your system and their partitioning schemes.                                                                          |
|                    |                                                                                                                                                                                                                    |

# Deliverables

## Project

## Technical Knowledge Assessment

# Links to Livestreams and Lecture Recordings

## Day 1 - Welcome, Introduction and Getting Started

## Day 2 - HPC Hardware, HPC Networking and Systems Administration

## Day 3 - Benchmarking, Compilation and Parallel Computing

## Day 4 - HPC Administration and Application Visualization

## Day 5 - Career Guidance


TODO: Add objectives for each Tutorial and section. They should be editable so students check them off as they go along.

# Tutorial Glossary and Section Overview

## Tutorial 1

Tutorial 1 deals with introducing concepts to users and getting them started with using the virtual lab, setting up networking and remotely connecting. The content is as follows:

1. [Checklist](tutorial1/README.md#checklist)
1. [Network Primer](tutorial1/README.md#network-primer)
    1. [Basic Networking Example (WhatIsMyIp.com)](tutorial1/README.md#basic-networking-example-whatismyipcom)
        1. [Local WiFi Network](tutorial1/README.md#local-wifi-network)
        1. [External Cellular Network](tutorial1/README.md#external-cellular-network)
        1. [WiFi Hotspot Example](tutorial1/README.md#wifi-hotspot-example)
1. [Launching your First Open Stack Virtual Machine Instance](tutorial1/README.md#launching-your-first-open-stack-virtual-machine-instance)
    1. [Accessing the NICIS Cloud](tutorial1/README.md#accessing-the-nicis-cloud)
    1. [Verify your Teams' Project Workspace and Available Resources](tutorial1/README.md#verify-your-teams-project-workspace-and-available-resources)
    1. [Generating SSH Keys](tutorial1/README.md#generating-ssh)
    1. [Launch a New Instance](tutorial1/README.md#launch-a-new-instance)
    1. [Linux Flavors and Distributions](tutorial1/README.md#linux-flavors-and-distributions)
        1. [Desktop Usage vs Server](tutorial1/README.md#desktop-usage-vs-server)
        1. [Table of Linux Distributions](tutorial1/README.md#table-of-linux-distributions)
    1. [OpenStack Instance Flavors](tutorial1/README.md#openstack-instance-flavors)
    1. [Networks, Ports, Services and Security Groups](tutorial1/README.md#networks-ports-services-and-security-groups)
    1. [Key Pair](tutorial1/README.md#key-pair)
    1. [Verify that your Instance was Successfully Deployed and Launched](tutorial1/README.md#verify-that-your-instance-was-successfully-deployed-and-launched)
    1. [Associating an Externally Accessible IP Address](tutorial1/README.md#associating-an-externally-accessible-ip-address)
    1. [Success State, Resource Management and Troubleshooting](tutorial1/README.md#success-state-resource-management-and-troubleshooting)
        1. [Deleting Instances](tutorial1/README.md#deleting-instances)
        1. [Deleting Volumes](tutorial1/README.md#deleting-volumes)
        1. [Dissociating and Releasing Floating IPs](tutorial1/README.md#dissociating-and-releasing-floating-ips)
1. [Introduction to Basic Linux Administration](tutorial1/README.md#introduction-to-basic-linux-administration)
    1. [Accessing your VM Using SSH vs the OpenStack Web Console (VNC)](tutorial1/README.md#accessing-your-vm-using-ssh-vs-the-openstack-web-console-vnc)
    1. [Basic Linux Commands and Linux Services](tutorial1/README.md#linux-services---understanding-journalctl-and-systemctl)
    1. [Verifying Instance Hostname and `/etc/hosts` File](tutorial1/README.md#verifying-instance-hostname-and-etchosts-file)
1. [Linux Binaries, Libraries and Package Management](tutorial1/README.md#linux-binaries-libraries-and-package-management)
1. [Install Dependencies and Fetch Source files for High Performance LinPACK (HPL) Benchmark](tutorial1/README.md#install-dependencies-and-fetch-source-files-for-high-performance-linpack-hpl-benchmark)
    1. [Install the GNU Compiler Collection (GCC)](tutorial1/README.md#install-the-gnu-compiler-collection-gcc)
    1. [Install OpenMPI](tutorial1/README.md#install-openmpi)
    1. [Install ATLAS Math Library](tutorial1/README.md#install-atlas-math-library)
    1. [Fetch and Extract the HPC Source Tarball](tutorial1/README.md#fetch-and-extract-the-hpc-source-tarball)
    1. [Copy and Edit the Makefile for _your_ Target Architecture](tutorial1/README.md#copy-and-edit-the-makefile-for-_your_-target-architecture)
1. [Compile the HPL Source Code to Produce an Executable Binary](tutorial1/README.md#compile-the-hpl-source-code-to-produce-an-executable-binary)
    1. [Editing _your_ PATH Variable](tutorial1/README.md#editing-_your_-path-variable)
    1. [Configuring _Your_ `HPL.dat` File Using `lscpu` and `lsmem`](tutorial1/README.md#configuring-_your_-hpldat-file-using-lscpu-and-lsmem)

## Tutorial 2

Tutorial 2 deals with understaning the roles of the head and compute nodes, adding a compute node to create your cluster, configuring linux services such as the firewall, time server.
1. [Checklist](tutorial2/README.md#checklist)
1. [Spinning Up a Compute Node in OpenStack](tutorial2/README.md#spinning-up-a-compute-node-in-openstack)
    1. [Compute Node Considerations](tutorial2/README.md#compute-node-considerations)
1. [Accessing Your Compute Node](tutorial2/README.md#accessing-your-compute-node)
    1. [IP Addresses and Routing](tutorial2/README.md#ip-addresses-and-routing)
    1. [Command Line Proxy Jump Directive](tutorial2/README.md#command-line-proxy-jump-directive)
        1. [Setting a Temporary Password on your Compute Node](tutorial2/#setting-a-temporary-passworwd-on-your-compute-node)
1. [Understanding the Roles of the Head Node and Compute Nodes](tutorial2/README.md#understanding-the-roles-of-the-head-node-and-compute-nodes)
   1. [Basic System Monitoring](tutorial2/README.md#basic-system-monitoring)
   1. [Terminal Multiplexers](tutorial2/README.md#terminal-multiplexers)
1. [Manipulating Files and Directories](tutorial2/README.md#manipulating-files-and-directories)
    1. [List Directory `ls`](tutorial2/README.md#list-directory-ls)
    1. [Change Directory `cd`](tutorial2/README.md#change-directory-cd)
    1. [Copy File or Directory `cp`](tutorial2/README.md#copy-file-or-directory-cp)
    1. [Move File or Directory `mv`](tutorial2/README.md#move-file-or-directory-mv)
    1. [Make a New Directory `mkdir`](tutorial2/README.md#make-a-new-directory-mkdir)
    1. [Remove File or Directory `rm`](tutorial2/README.md#remove-file-or-directory-rm)
    1. [Recommended Project Folder Structure](tutorial2/README.md#recommended-project-folder-structure)
1. [Verifying Networking Setup](tutorial2/README.md#verifying-networking-setup)
    1. [Head Node](tutorial2/README.md#head-node)
    1. [Compute Node](tutorial2/README.md#compute-node)
    1. [Editing `/etc/hosts` File](tutorial2/README.md#editing-etchosts-file)
    1. [Permanent `~/.ssh/config` Configuration](tutorial2/README.md#permanent-sshconfig-configuration)
1. [Configuring a Simple Stateful Firewall](tutorial2/README.md#configuring-a-simple-stateful-firewall)
    1. [IPTables](tutorial2/README.md#iptables)
    1. [NFTables](tutorial2/README.md#nftables)
    1. [Front-end Firewall Application Managers](tutorial2/README.md#front-end-firewall-application-managers)
1. [Network Time Protocol](tutorial2/README.md#network-time-protocol)
    1. [NTP Server (Head Node)](tutorial2/README.md#ntp-server-head-node)
    1. [NTP Client (Compute Node)](tutorial2/README.md#ntp-client-compute-node)
1. [Network File System](tutorial2/README.md#network-file-system)
    1. [NFS Server (Head Node)](tutorial2/README.md#nfs-server-head-node)
    1. [NFS Client (Compute Node)](tutorial2/README.md#nfs-client-compute-node)
        1. [Mounting An NFS Mount](tutorial2/README.md#mounting-an-nfs-mount)
        1. [Making The NFS Mount Permanent](tutorial2/README.md#making-the-nfs-mount-permanent)
    1. [Passwordless SSH](tutorial2/README.md#passwordless-ssh)
        1. [Generating SSH Keys on Your Head Node](tutorial2/README.md#generating-ssh-keys-on-your-head-node)
        1. [Understanding `~/.ssh/authorized_keys`](tutorial2/README.md#understanding-ssh/authorized_keys)
        1. [User Permissions and Ownership](tutorial2/README.md#user-permissions-and-ownership)
1. [User Account Management](tutorial2/README.md#user-account-management)
    1. [Create Team Captain User Account](tutorial2/README.md#create-team-captain-user-account)
        1. [Head Node](tutorial2/README.md#head-node-1)
        1. [Compute Node](tutorial2/README.md#compute-node-1)
        1. [Super User Access](tutorial2/README.md#super-user-access)
    1. [Out-Of-Sync Users and Groups](tutorial2/README.md#out-of-sync-users-and-groups)
        1. [Head Node](tutorial2/README.md#head-node-2)
        1. [Compute Node](tutorial2/README.md#compute-node-2)
        1. [Clean Up](tutorial2/README.md#clean-up)
    1. [Ansible User Declaration](tutorial2/README.md#ansible-user-declaration)
        1. [Installing and Configuring Ansible](tutorial2/README.md#installing-and-configuring-ansible)
        1. [Create Team Member Accounts](tutorial2/README.md#create-team-member-accounts)
1. [Remote Access to Your Cluster and Tunneling](tutorial2/README.md#remote-access-to-your-cluster-and-tunneling)
    1. [Local Port Forwarding](tutorial2/README.md#local-port-forwarding)
    1. [Dynamic Port Forwarding](tutorial2/README.md#dynamic-port-forwarding)
        1. [Web Browser and SOCKS5 Proxy Configuration](tutorial2/README.md#web-browser-and-socks5-proxy-configuration)
    1. [WirGuard VPN Cluster Access](tutorial2/README.md#wirguard-vpn-cluster-access)
    1. [ZeroTier](tutorial2/README.md#zerotier)
    1. [X11 Forwarding](tutorial2/README.md#x11-forwarding)


## Tutorial 3

1. [Checklist](tutorial3/README.md#checklist)
1. [Managing Your Environment](tutorial3/README.md#managing-your-environment)
    1. [NFS Mounted Shared `home` folder and the `PATH` Variable](tutorial3/README.md#nfs-mounted-shared-home-folder-and-the-path-variable)
    1. [System Software Across Multiple Nodes](tutorial3/README.md#system-software-across-multiple-nodes)
    1. [Environment Modules](tutorial3/README.md#environment-modules)
1. [Install Lmod](tutorial3/README.md#install-lmod)
    1. [Lmod Usage](tutorial3/README.md#lmod-usage)
    1. [Adding Modules to Lmod](tutorial3/README.md#adding-modules-to-lmod)
1. [Running the High Performance LINPACK (HPL) Benchmark on Your Compute Node](tutorial3/README.md#running-the-high-performance-linpack-hpl-benchmark-on-your-compute-node)
    1. [System Libraries](tutorial3/README.md#system-libraries)
        1. [Static Libraries](tutorial3/README.md#static-libraries)
        1. [Dynamic Libraries](tutorial3/README.md#dynamic-libraries)
    1. [Message Passing Interface (MPI)](tutorial3/README.md#message-passing-interface-mpi)
    1. [Basic Linear Algebra Subprograms Libraries](tutorial3/README.md#basic-linear-algebra-subprograms-libraries)
    1. [Install HPL](tutorial3/README.md#install-hpl)
1. [Spinning Up a Second Compute Node](tutorial3/README.md#spinning-up-a-second-compute-node)
    1. [Cluster Considerations](tutorial3/README.md#cluster-considerations)
    1. [Using a Snapshot](tutorial3/README.md#using-a-snapshot)
    1. [Running HPC Across Multiple Nodes](tutorial3/README.md#running-hpc-across-multiple-nodes)
        1. [Configuring OpenMPI Hosts File](tutorial3/README.md#configuring-openmpi-hosts-file)
        1. [Runtime Configuration Options for `mpirun`](tutorial3/README.md#runtime-configuration-options-for-mpirun)
1. [Building and Compiling GCC, OpenMPI and BLAS Libraries from Source](tutorial3/README.md#building-and-compiling-gcc-openmpi-and-blas-libraries-from-source)
    1. [Compiler](tutorial3/README.md#compiler)
    1. [OpenMPI](tutorial3/README.md#openmpi)
    1. [BLAS Library](tutorial3/README.md#blas-library)
1. [Intel oneAPI Toolkit and Compiler Suite](tutorial3/README.md#intel-oneapi-toolkit-and-compiler-suite)
    1. [Configure and Install Intel oneAPI Base and HPC Toolkits](tutorial3/README.md#configure-and-install-intel-oneapi-base-and-hpc-toolkits)
    1. [Configuring and Running HPL with Intel oneAPI Toolkit and MKL](tutorial3/README.md#configuring-and-running-hpl-with-intel-oneapi-toolkit-and-mkl)
1. [LinPACK Theoretical Peak Performance](tutorial3/README.md#linpack-theoretical-peak-performance)
    1. [Top500 List](tutorial3/README.md#top500-list)
    1. [Plot a Graph of Your HPL Benchmark Results](tutorial3/README.md#plot-a-graph-of-your-hpl-benchmark-results)
1. [HPC Challenge](tutorial3/README.md#hpc-challenge)
1. [GROMACS Application Benchmark](tutorial3/README.md#gromacs-application-benchmark)
    1. [Installation](tutorial3/README.md#installation)
    1. [Application Benchmark and System Evaluation](tutorial3/README.md#application-benchmark-and-system-evaluation)
        1. [Benchmark 1 (adh_cubic):](tutorial3/README.md#benchmark-1-adh_cubic)
1. [LAMMPS Application Benchmark](tutorial3/README.md#lammps-application-benchmark)
1. [Qiskit Application Benchmark](tutorial3/README.md#qiskit-application-benchmark)

## Tutorial 4

1. [Checklist](tutorial4/README.md#checklist)
1. [Cluster Monitoring](tutorial4/README.md#cluster-monitoring)
   1. [Prometheus](tutorial4/README.md#prometheus)
   1. [Node Exporter](tutorial4/README.md#node-exporter)
   1. [Grafana](tutorial4/README.md#grafana)
1. [Slurm Scheduler and Workload Manager](tutorial4/README.md#slurm-scheduler-and-workload-manager)
    1. [Prerequisites](tutorial4/README.md#prerequisites)
    1. [Head Node Configuration (Server)](tutorial4/README.md#head-node-configuration-server)
    1. [Compute Node Configuration (Clients)](tutorial4/README.md#compute-node-configuration-clients)
    1. [Configure Grafana Dashboard for Slurm](tutorial4/README.md#configure-grafana-dashboard-for-slurm)
1. [GROMACS Application Benchmark](tutorial4/README.md#gromacs-application-benchmark)
    1. [Protein Visualisation](tutorial4/README.md#gromacs-protein-visualisation)
    1. [Benchmark 2 (1.5M_water)](tutorial4/README.md#benchmark-2-15m_water)
1. [Running Qiskit from a Remote Jupyter Notebook Server](tutorial4/README.md#running-qiskit-from-a-remote-jupyter-notebook-server)
1. [Automating the Deployment of your OpenStack Instances Using Terraform](tutorial4/README.md#automating-the-deployment-of-your-openstack-instances-using-terraform)
1. [Continuous Integration Using CircleCI](tutorial4/README.md#continuous-integration-using-circleci)
1. [Automating the Configuration of your VMs Using Ansisble](tutorial4/README.md#automating-the-configuration-of-your-vms-using-ansible)

# Contributing to the Project

> [!IMPORTANT] While we value your feedback, the following sections are primarily targeted as _Contributors to the Project_. As a student participating in the competition, do **NOT** spend your time working through any of the material below.

You are strongly encouraged to contribute and improve the project by [Opening and Participating in Discussions](https://github.com/chpc-tech-eval/chpc24-scc-nmu/discussions), [Raising, Addressing and Resolving Issues](https://github.com/chpc-tech-eval/chpc24-scc-nmu/issues). The following guide describes [How to clone, push, and pull with git (beginners GitHub tutorial)](https://youtu.be/yxvqLBHZfXk?si=jFFdP1XafscVX9BF).

## Steps to follow when editing existing content

In order to effectively manage the various workflows and stages of development, testing and deployment, the project is comprised of three primary branches:
* `main`: *Stable* and production-ready deployment branch of the project.
* `stag`: *Staging* branch which mirrors production and is used for integration testing of new features.
* `dev`: *Development* branch for incorporating new features and bug fixes.

Editing the content directly, will require the use of Git. Using a terminal application or [Git for Windows PowerShell](https://git-scm.com/book/en/v2/Appendix-A:-Git-in-Other-Environments-Git-in-PowerShell) or [Git for MobaXTerm](https://www.geeksforgeeks.org/how-to-install-git-on-mobaxterm/).

1. [Generate an SSH Key](#tutorial1/README.md#generating-ssh-keys) (or use an existing one).
1. Add your SSH key to your Git profile.
   - Navigate to your *'Profile'* and go to *'Settings'*.
   - Under *'Access'*, navigate to *'SSH and GPG Keys'*
     <p align="center"><img alt="Adding SSH Keys to GitHub." src="./resources/github_profile_settings_highlight.png" width=900 /></p>
     
1. `git clone` a local copy of the repository, to your personal work space.
   <p align="center"><img alt="Adding SSH Keys to GitHub." src="./resources/github_clone.png" width=900 /></p>
   
   You can copy the command from GitHub itself.
   
   ```bash
   git clone git@github.com:chpc-tech-eval/chpc24-scc-nmu.git
   ```
1. When starting work on a new feature or bug fix, create a feature branch off of the development branch and regularly get updates from `dev` to ensure that you remain consistent with any changes to `dev`:
   ```bash
   git checkout dev
   git pull origin dev
   ```
1. Create a new branch to work on. i.e. `git branch tutX/bugfix-or-new-feature` followed by `git checkout tutX/bugfix-or-new-feature`, or simply use a single command `git checkout -b tutX/bugfix-or-new-feature`.
   - Give the branch a sensible name.
   - You are encouraged to push the branch back to the remote so that collaborators can see what you are working on as you make the changes.
1. Make the appropriate changes and commit them locally:
   ```bash
   git add <relative_path_to_changed_file(s)>
   git commit -m "some_message_pertaining_to_changes_made"
   ```
1. When you have completed editing your feature, merge any remote changes from `dev` and then `push` your local changes, back upstream to the remote repository:
   ```bash
   git pull origin dev # (optional) it is generally a good practice to incorporate any changes in dev into your code early and often
   git pull origin feature/bugfix-or-new-feature # (optional) if you are collaborating on a specific feature with someone, it is important to incorporate their changes early and often
   git push origin feature/bugfix-or-new-feature
   ```
1. Once you are satisfied with the changes you've have been editing, eliminate all merge conflicts by pulling all remote changes and deviations into your local working copy. `git pull`.
   - If you are confident that your feature does not or has not deviated from the remote `dev` branch, use `git pull` to automatically `fetch` and `merge` remote changes from `dev` into your feature branch.
   - Alternatively, if your branch is old, or depends on / requires changes from remote use `git fetch`, to `fetch` remote changes and be able to preview them before merging.
   - Eliminate your local conflicts and merge all remote changes `git merge`.
   - Once all the conflicts have been resolved, and you've successfully merged all remote changes, push your branch upstream.
1. [Create a pull request](https://github.com/chpc-tech-eval/chpc24-scc-nmu/compare/dev...dev) to the remote `dev` branch on GitHub, to incorporate your feature.
   - Or another branch, if your feature branch was adding functionality to an existing feature branch.

## Syntax and Style

Use the following guide on [Github Markdown Syntax Editing](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github)

# Collaborating with your Team and Storing you Progress on GitHub

## Forking the Tutorials into Your Own Team's Private GitHub Repository

## Editing the Git Markdown Files to Track Your Team's Progress
