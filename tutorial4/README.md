# Student Cluster Compeititon - Tutorial 4

## Table of Contents
<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->

1. [Checklist](#checklist)
    1. [(Delete) - Remote Web Service Access](#delete---remote-web-service-access)
1. [Prometheus](#prometheus)
    1. [Edit YML Configuration File](#edit-yml-configuration-file)
    1. [Configuring Prometheus as a Service](#configuring-prometheus-as-a-service)
    1. [SSH Port Forwarding](#ssh-port-forwarding)
    1. [Dynamic SSH Forwarding (SOCKS Proxy)](#dynamic-ssh-forwarding-socks-proxy)
        1. [Configuring Your Browser](#configuring-your-browser)
    1. [X11 Forwarding](#x11-forwarding)
1. [Grafana](#grafana)
    1. [Configuring Grafana Dashboards](#configuring-grafana-dashboards)
1. [Node Exporter](#node-exporter)
    1. [Configuring Node Exporter as a Service](#configuring-node-exporter-as-a-service)
1. [Slurm Scheduler and Workload Manager](#slurm-scheduler-and-workload-manager)
    1. [Prerequisites](#prerequisites)
    1. [Head Node Configuration (Server)](#head-node-configuration-server)
    1. [Compute Node Configuration (Clients)](#compute-node-configuration-clients)
    1. [Configure Grafana Dashboard for Slurm](#configure-grafana-dashboard-for-slurm)
1. [GROMACS Protein Visualisation](#gromacs-protein-visualisation)
1. [Running Qiskit from a Remote Jupyter Notebook Server](#running-qiskit-from-a-remote-jupyter-notebook-server)
1. [Automating the Deployment of your OpenStack Instances Using Terraform](#automating-the-deployment-of-your-openstack-instances-using-terraform)
1. [Automating the Configuration of your VMs Using Ansisble](#automating-the-configuration-of-your-vms-using-ansible)
1. [Introduction to Continuous Integration](#introduction-to-continuous-integration)
    1. [GitHub](#github)
    1. [TravisCI](#travisci)
    1. [CircleCI](#circleci)

<!-- markdown-toc end -->

# Checklist

Tutorial 4 demonstrates environment module manipulation and the compilation and optimisation of HPC benchmark software. This introduces the reader to the concepts of environment management and workspace sanity, as well as compilation of software on Linux.


This tutorial demonstrates _cluster monitoring_ and _workload scheduling_. These two components are critical to a typical HPC environment. Monitoring is a widely used component in system administration (including enterprise datacentres and corporate networks). Monitoring allows administrators to be aware of what is happening on any system that is being monitored and is useful to proactively identify where any potential issues may be. A workload scheduler ensures that users' jobs are handled properly to fairly balance all scheduled jobs with the resources available at any time.

In this tutorial you will:

- [ ] Install the Zabbix monitoring server on your head node.
- [ ] Install Zabbix monitoring clients on your compute node(s).
- [ ] Configure Zabbix in order to monitor your virtual HPC cluster.
- [ ] Install the Slurm workload manager across your cluster.
- [ ] Submit a test job to run on your cluster through the newly-configured workload manager.

<div style="page-break-after: always;"></div>

In this tutorial you will:

- [ ] Create Slurm batch scripts to submit jobs for your benchmark runs.
- [ ] Optimise HPL.
- [ ] Download and compile the High Performance Computing Challenge (HPCC) benchmark.

> [!TIP]
> You're going to be manipulating both your headnode, as well as your compute node(s) in this tutorial.
>
> You are *strongly* advised to make use of a terminal multiplexer, such as `tmux` before making a connection to your VMs.
>
>```bash
>$ tmux
>```
>
> Split the window into two separate panes with `ctrl + b |`.
> SSH into your headnode, on the one pane, and ssh into your compute node with a hop over your headnode, recall the jumpbox directive.
>
> **************Insert image of terminal here***************

<div style="page-break-after: always;"></div>

## (Delete) - Remote Web Service Access

During the course of the competition, you will set up services on your head node that you need to access via a web browser. Considering that your cluster is not directly accessible from the internet, you will need to create an **SSH tunnel** (utilising port forwarding) between your local machine and your head node to access these webpages.

> **! >>> Please read and familiarise yourself with the concept of a _port_ before continuing:**
> - **[Dummies.com - Network Basics: TCP/UDP Socker and Port Overview](https://www.dummies.com/programming/networking/cisco/network-basics-tcpudp-socket-and-port-overview/)**
> - **[Wikipedia - Port (computer networking)](https://en.wikipedia.org/wiki/Port_(computer_networking))**

We'll demonstrate how this is done. First, let's create a simple web page that you can serve from your head node. To do this, you need to install a web server. [Apache](https://httpd.apache.org/) is a standard and widely used open-source web server. To install it:

```bash
~$ dnf install httpd
```

You'll then need to enable and start the web server service.

```bash
~$ systemctl start httpd   # Starts the service
~$ systemctl enable httpd  # Sets service to start on reboot automatically
```
Confirm that it's up and running with the following:

```bash
~$ systemctl status httpd
```

You now have a running web server. Apache has a default available test-page, but since **the networks for your cluster aren't available outside the ACE Lab private network**, you **can't** simply type the IP address of the head node into your local web browser to access it. To access the test-page (served by your head node) you must establish a tunnel between your local machine and the head node, using the ACE Lab login node (ssh.ace.chpc.ac.za) as a middle-man. This is done using `ssh`.

You need to establish a specific SSH tunnel to achieve this. The specific tunnel demonstrated below is known as an SSH forward tunnel, or SSH local port forwarding. To achieve this, you must tell the `ssh` client on your **local machine (computer at home)** that you will be sending and receiving data to and from a specific port on the **target machine (your head node in this case)** via a specific port on your **local machine**.

Once this tunnel is established, you will be able to open your **local web browser** and access the **local port (the one that you configured to have data forwarded to from the head node)** to see the data forwarded from the target port. Connecting to the local port will request that the data be sent from the target machine - showing you the web page as if you were on the same network as the head node.

Web traffic is by default served on **port 80**. This is thus chosen as the **target port on the head node**, as you want to be able to view this web traffic on your local computer. For the **local port**, we can choose **any port number greater than 1000**, as anything over 1000 is non-system and non-privileged (doesn't require root access).

> **! >>> Please note that the IP address used below is an example.**
> **! >>> The IP address to use instead of 192.168.0.xx is your HEADNODE public IP.**

<span id="fig1.1" class="img_container center" style="font-size:8px;margin-bottom:0px; display: block;">
    <img alt="webserver" src="./resources/tut2_fig_part1_ssh_tunnel.png" style="display:block; margin-left: auto; margin-right: auto; width: 75%;" title="caption" />
    <span class="img_caption" style="display: block; text-align: center;margin-left: auto;
    margin-right: auto; width: 50%;"><i>Figure 1.1: SSH -L tunnel as described below.</i></span>
</span>

1. Firstly, let us allow web traffic through the head node firewall (this is done on the **head node**):

    ```bash
    ~$ firewall-cmd --zone=external --add-service=http --permanent
    ~$ firewall-cmd --reload
    ```

2. On your **local machine**, open up the tunnel from the head node's port 80 to your machine's port 8080 ([Figure 1.1](#fig1.1)):

    ```bash
    ~$ ssh -L 8080:10.128.24.XX:80 <team_name>@ssh.ace.chpc.ac.za
    ```

    This command uses the following syntax:

    ```
    ssh -L <localhost_port:target_host:target_host_port> <username>@<remote_host>
    ```

    The `-L` specifies that you want to create a port forward to/from your `<localhost_port>` to the `<target_host_port>` of the `<target_host>`.

3. Open up your browser and visit:

    ```bash
    http://127.0.0.1:8080 # 127.0.0.1 is a reference to your own machine, you could also say http://localhost:8080
    ```

If it is up and running correctly, you should see the default test-page for your Apache server ([Figure 1.2](#fig1.2)).

<span id="fig1.2" class="img_container center" style="font-size:8px;margin-bottom:0px; display: block;">
    <img alt="webserver" src="./resources/apache_default_page.png" style="display:block; margin-left: auto; margin-right: auto; width: 50%;" title="caption" />
    <span class="img_caption" style="display: block; text-align: center;margin-left: auto;
    margin-right: auto; width: 50%;"><i>Figure 1.2: The default page for the Apache web server seen through the local browser.</i></span>
</span>

**Windows users with PuTTY, please follow this guide: [https://stackoverflow.com/questions/4974131/how-to-create-ssh-tunnel-using-putty-in-windows/29168936#29168936](https://stackoverflow.com/questions/4974131/how-to-create-ssh-tunnel-using-putty-in-windows/29168936#29168936).**

To clarify, what the `ssh` command above does is the following:

The `-L 8080:10.128.24.XX:80` tells the `ssh` client that you want to map your local machine port `8080` to the head node's port `80`. However, your local machine can't reach the head node directly since you're not on the same network. In order to know how to get to the head node, you still connect to the login node for the ACE Lab, which is why you specify the `<team_name>@ssh.ace.chpc.ac.za`. The `ssh` client will know to map your port `8080` to the head node's port `80` **via** `ssh.ace.chpc.ac.za`.


<div style="page-break-after: always;"></div>



# Prometheus

Prometheus can be [installed](https://prometheus.io/docs/prometheus/latest/installation/) using either pre-compiled binaries, source, docker containers or from configuration management systems such as Ansible or Puppet.

From the [Pre-Compiled Binaries Download Page](https://prometheus.io/download/), 

## Edit YML Configuration File

## Configuring Prometheus as a Service

## SSH Port Forwarding
Starting a browser on the remote server
## Dynamic SSH Forwarding (SOCKS Proxy)

### Configuring Your Browser

## X11 Forwarding

# Grafana

## Configuring Grafana Dashboards 

# Node Exporter

## Configuring Node Exporter as a Service

# Slurm Scheduler and Workload Manager

The Slurm Workload Manager (formerly known as Simple Linux Utility for Resource Management), is a free and open-source job scheduler for Linux, used by many of the world's supercomputers/computer clusters. It allows you to manage the resources of a cluster by deciding how users get access for some duration of time so they can perform work. To find out more, please visit the [Slurm Website](https://slurm.schedmd.com/documentation.html).

## Prerequisites

1. Make sure the clocks, i.e. chrony daemons, are synchronized across the cluster.

2. Generate a SLURM and MUNGE user on all of your nodes:

    - **If you have FreeIPA authentication working**
        - Create the users using the FreeIPA web interface. **Do NOT add them to the sysadmin group**.
    - **If you do NOT have FreeIPA authentication working**
       - `useradd slurm`
       - Ensure that users and groups (UIDs and GIDs) are synchronized across the cluster. Read up on the appropriate [/etc/shadow](https://linuxize.com/post/etc-shadow-file/) and [/etc/password](https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/) files.

## Head Node Configuration (Server) 


1. Install the [MUNGE](https://dun.github.io/munge/) package. MUNGE is an authentication service that makes sure user credentials are valid and is specifically designed for HPC use.

    First, we will enable the **EPEL** _(Extra Packages for Enterprise Linux)_ repository for `dnf`, which contains extra software that we require for MUNGE and Slurm:

    ```bash
    [...@headnode ~]$ sudo dnf install epel-release
    ```

    Then we can install MUNGE, pulling the development source code from the `powertools` repository:

    ```bash
    [...@headnode ~]$ sudo dnf --enablerepo=powertools install munge munge-libs munge-devel
    ```

2. Generate a MUNGE key for client authentication:

    ```bash
    [...@headnode ~]$ sudo /usr/sbin/create-munge-key -r
    [...@headnode ~]$ sudo chown munge:munge /etc/munge/munge.key
    [...@headnode ~]$ sudo chmod 600 /etc/munge/munge.key
    ```

3. Using `scp`, copy the MUNGE key to your compute node to allow it to authenticate:

    1. SSH into your compute node and create the directory `/etc/munge`. Then exit back to the head node.

    2.  `scp /etc/munge/munge.key <compute_node_name_or_ip>:/etc/munge/munge.key`

4. **Start** and **enable** the `munge` service

5. Install dependency packages:

    ```bash
    [...@headnode ~]$ sudo dnf --enablerepo=powertools install python3 gcc openssl openssl-devel pam-devel numactl \
                        numactl-devel hwloc lua readline-devel ncurses-devel man2html libibmad libibumad \
                        rpm-build perl-ExtUtils-MakeMaker rrdtool-devel lua-devel hwloc-devel \
                        perl-Switch libssh2-devel mariadb-devel
    [...@headnode ~]$ sudo dnf groupinstall "Development Tools"
    ```

6. Download the 20.11.9 version of the Slurm source code tarball (.tar.bz2) from https://download.schedmd.com/slurm/. Copy the URL for `slurm-20.11.9.tar.bz2` from your browser and use the `wget` command to easily download files directly to your VM.

7. Environment variables are a convenient way to store a name and value for easier recovery when they're needed. Export the version of the tarball you downloaded to the environment variable VERSION. This will make installation easier as you will see how we reference the environment variable instead of typing out the version number at every instance.

    ```bash
    [...@headnode ~]$ export VERSION=20.11.9
    ```

8. Build RPM packages for Slurm for installation

    ```bash
    [...@headnode ~]$ sudo rpmbuild -ta slurm-$VERSION.tar.bz2
    ```

    This should successfully generate Slurm RPMs in the directory that you invoked the `rpmbuild` command from.
    
9. Copy these RPMs to your compute node to install later, using `scp`.

10. Install Slurm server

    ```bash
    [...@headnode ~]$ sudo mkdir -p /var/log/slurm /var/spool/slurm/ctld /var/spool/slurm/d
    [...@headnode ~]$ sudo chown -R slurm:slurm /var/log/slurm /var/spool/slurm/ctld /var/spool/slurm/d
    [root@headnode ~]$ cd /root/rpmbuild/RPMS/x86_64/
    [root@headnode ~]$ dnf localinstall slurm-$VERSION*.rpm slurm-devel-$VERSION*.rpm \
                         slurm-example-configs-$VERSION*.rpm slurm-perlapi-$VERSION*.rpm \
                         slurm-torque-$VERSION*.rpm slurm-slurmctld-$VERSION*.rpm
    ```

11. Setup Slurm server

    ```bash
    [...@headnode ~]$ sudo cp /etc/slurm/slurm.conf.example /etc/slurm/slurm.conf
    ```

    Edit this file (`/etc/slurm/slurm.conf`) and set appropriate values for:

    ```conf
    ClusterName=      #Name of your cluster (whatever you want)
    ControlMachine=   #DNS name of the head node
    ```

    Populate the nodes and partitions at the bottom with the following two lines:

    ```conf
    NodeName=<computenode> Sockets=<num_sockets> CoresPerSocket=<num_cpu_cores> \ 
    ThreadsPerCore=<num_threads_per_core> State=UNKNOWN
    ```

    ```conf
    PartitionName=debug Nodes=ALL Default=YES MaxTime=INFINITE State=UP
    ```

    **To check how many cores your compute node has, run `lscpu` on the compute node.** You will get output including `CPU(s)`, `Thread(s) per core`, `Core(s) per socket` and more that will help you determine what to use for the Slurm configuration.

    **Hint: if you overspec your compute resources in the definition file then Slurm will not be able to use the nodes.**

12. **Start** and **enable** the `slurmctld` service on the head node.

## Compute Node Configuration (Clients)

1. Setup MUNGE:

    ```bash
    [...@computenode ~]$ sudo dnf install munge munge-libs
    [...@computenode ~]$ sudo chown -R munge:munge /etc/munge/munge.key
    ```

2. **Start** and **enable** the `munge` service.

3. Test MUNGE to the head node:

    ```bash
    [...@computenode ~]$ munge -n | ssh headnode.cluster.scc unmunge 
    [...@computenode ~]$ remunge 
    ```
4. The `.rpm` files that were previously created on the head node must be made available to the compute node. Either copy the `.rpm` files to the compute node or move them to an NFS shared directory on your head node so that they are accessible on the compute node. Next, install the Slurm client on the compute node. Once again export the version of your Slurm instance to the environment variable `$VERSION`:

    ```bash
    [...@computenode ~]$ sudo dnf --enablerepo=powertools install perl-Switch perl-ExtUtils-MakeMaker
    [...@computenode ~]$ sudo dnf localinstall slurm-$VERSION*.rpm slurm-devel-$VERSION*.rpm  \
                          slurm-perlapi-$VERSION*.rpm slurm-torque-$VERSION*.rpm \
                          slurm-example-configs-$VERSION*.rpm slurm-slurmd-$VERSION*.rpm \
                          slurm-pam_slurm-$VERSION*.rpm
    ```

5. Create the `/var/spool/slurm/d` directory and make it owned by user and group `slurm`.

6. Copy the `slurm.conf` file you editted on your head node to the same location on your compute node.

7. **Start** and **enable** the `slurmd` service.


Return to your head node. To demonstrate that your scheduler is working you can run the following command as your normal user:

```bash
[...@headnode ~]$ sinfo 
```

You should see your compute node in an idle state.

Slurm allows for jobs to be submitted in _batch_ (set-and-forget) or _interactive_ (real-time response to the user) modes. Start an interactive session on your compute node via the scheduler with

```bash
[...@headnode ~]$ srun -N 1 --pty bash 
```

You should automatically be logged into your compute node. This is done via Slurm. Re-run `sinfo` now and also run the command `squeue`. Here you will see that your compute node is now allocated to this job.

To finish, type `exit` and you'll be placed back on your head node. If you run `squeue` again, you will now see that the list is empty.

<div style="page-break-after: always;"></div>

To confirm that your node configuration is correct, you can run the following command on the head node:

```bash
[...@headnode ~]$ sinfo -alN
```

The `S:C:T` column means "sockets, cores, threads" and your numbers for your compute node should match the settings that you made in the `slurm.conf` file.
## Configure Grafana Dashboard for Slurm

# GROMACS Protein Visualisation

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

# Running Qiskit from a Remote Jupyter Notebook Server


# Automating the Deployment of your OpenStack Instances Using Terraform

## 

# Automating the Configuration of your VMs Using Ansible

# Introduction to Continuous Integration
## GitHub
## TravisCI
## CircleCI
