# Student Cluster Competition - Tutorial 1

## Table of Contents

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
1. [Overview](#overview)
   1. [Checklist](#checklist)
1. [Network Primer](#network-primer)
   1. [Internal Intranet vs External Internet](#internal-intranet-vs-external-internet)
      1. [WiFi Hotspot Example](#wifi-hotspot-example)
      1. [WhatIsMyIp.com](#whatismyipcom)
   1. [Windows PowerShell Commands](#windows-powershell-commands)
      1. [`ipconfig`](#ipconfig)
      1. [`ping 8.8.8.8`](#ping-8888)qqq
      1. [`route print`](#route-print)
      1. [`tracert`](#tracert)
   1. [Understanding NAT](#understanding-nat)
      1. [Publicly Accessible IP Address](#publicly-accessible-ip-address)
      1. [Network Ports](#network-ports)
      1. [Internal Subnet](#internal-subnet)
      1. [Default Gateway and Routing Table](#default-gateway-and-routing-table)
1. [Launching your First OpenStack Virtual Machine Instance](#launching-your-first-open-stack-virtual-machine-instance)
   1. [Accessing the CHPC's Cloud](#accessing-the-chpcs-cloud)
   1. [Verify your Teams' Project Workspace](#verify-your-teams-project-workspace)
   1. [Verify your Teams' Available Resources and Launch a New Instance](#verify-your-teams-available-resources-and-launch-a-new-instance)
   1. [Instance Name](#instance-name)
   1. [Linux Flavors and Distributions](#linux-flavors-and-distributions)
      1. [Desktop Usage vs Server](#desktop-usage-vs-server)
      1. [Table of Linux Distributions](#table-of-linux-distributions)
   1. [OpenStack Instance Flavors](#openstack-instance-flavors)
      1. [Compute](#compute)
      1. [Memory](#memory)
      1. [Storage](#storage)
   1. [Networks, Ports, Services and Security Groups](#networks-ports-services-and-security-groups)
   1. [Generating SSH Keys](#generating-ssh-keys)
   1. [Verify that your Instance was Successfully Deployed and Launched](#verify-that-your-instance-was-successfully-deployed-and-launched)
   1. [Associating an Externally Available IP Address](#associating-an-externally-available-ip-address)
   1. [Success State, Resource Management and Trouble Shooting](#success-state-resource-management-and-trouble-shooting)
      1. [Deleting Instances](#deleting-instances)
      1. [Deleting Volumes](#deleting-volumes)
      1. [Dissociating and Releasing Floating IPs](#dissociating-and-releasing-floating-ips)
1. [Introduction to Basic Linux Administration](#introduction-to-basic-linux-administration)
   1. [Accessing your VM Using SSH vs the OpenStack Web Console (VNC)](#accessing-your-vm-using-ssh-vs-the-openstack-web-console-vnc)
      1. [SSH Through a Linux Terminal](#ssh-through-a-linux-terminal)
      1. [PuTTY and / or Windows Power Shell](#putty-and--or-windows-power-shell)
   1. [Username and Password](#username-and-password)
   1. [Brief Introduction to Text Editors (Vi vs Vim vs Nano vs Emacs)](#brief-introduction-to-text-editors-vi-vs-vim-vs-nano-vs-emacs)
   1. [Privilege Escalation and `sudo`](#privilege-escalation-and-sudo)
   1. [Linux Binaries, Libraries and Package Management](#linux-binaries-libraries-and-package-management)
   1. [Verifying Instance Hostname and `/etc/hosts` File](#verifying-instance-hostname-and-etchosts-file)
1. [Install Dependencies and Fetch Source files for High Performance LinPACK (HPL) Benchmark](#install-dependencies-and-fetch-source-files-for-high-performance-linpapl-benchmark)
   1. [Install the GNU Compiler Collection (GCC)](#install-the-gnu-compiler-collection-gcc)
   1. [Install OpenMPI](#install-openmpi)
   1. [Install ATLAS Math Library](#install-atlas-math-library)
   1. [Fetch and Extract the HPC Source Tarball](#fetch-and-extract-the-hpc-source-tarball)
   1. [Copy and Edit the Makefile for _your_ Target Architecture](#copy-and-edit-the-makefile-for-_your_-target-architecture)
1. [Compile the HPL Source Code to Produce an Executable Binary](#compile-the-hpl-source-code-to-produce-an-executable-binary)
   1. [Editing _your_ PATH Variable](#editing-_your_-path-variable)
      1. [Dynamic and Static Libraries: Editing _Your_ ATLAS Shared Object Files](#dynamic-and-static-libraries-editing-_your_-atlas-shared-object-files)
   1. [Configuring _Your_ `HPL.dat` File Using `lscpu` and `lsmem`](#configuring-_your_-hpldat-file-using-lscpu-and-lsmem)

<!-- markdown-toc end -->

## Overview

This tutorial will help you become familiar with Cloud Computing and will also serve as an introduction to Linux. This tutorial will start with a network primer that will help you to understand the basics of public and private networks, ip addresses, ports and routing.

You will then login into the CHPC's Cloud Computing Platform and launch your own OpenStack virtual machine instances. Here you will need to make a decision on choice of Linux distribution that you will use as well as how your team will allocate your limited cloud computing resources. 

such as navigating and configuring your hosts and network on the terminal. If you are new to Linux and need help getting more comfortable, please check out the resources tab on the learning system.

Once your team has successfully launched your instances you'll login to your VM's to do some basic Linux administration.

This tutorial will conclude with you downloading, installing and running the High Performance LinPACK benchmark on your newly created VM's.

### Checklist

<u>Use the following checklist to keep track of your team's progress and to ensure that all members in your understand these concepts.</u>

- [ ] Understand IT concepts like cloud computing, virtualisation and remote connections:
  - [ ] Understand and be able to explain networking terms such as URL, DNS, IP Address, Port, Subnet, Gateway, Router, and
  - [ ] Understand the difference between a Local Private Network and an External Public Network.
- [ ] Learn how to use the CHPC's cloud computing environment:
  - [ ] Learn about different Linux Distributions and Flavors, and
  - [ ] Learn about Cloud Resource Management.
- [ ] Learn about Basic Linux Administration:
  - [ ] Learn what SSH is and how to use it,
  - [ ] Learn about Linux password management,
  - [ ] Use a Linux Console / Terminal Based Text Editors,
  - [ ] Understand Linux Privileges and the Root user,
  - [ ] Learn how to Install Packages in your Linux Environment, and
  - [ ] Learn about Configuring system files.
- [ ] Download, Configure, Install and Run HPL Benchmark:
  - [ ] Understand how to satisfy Linux Package Dependencies,
  - [ ] Download and unpack files using a terminal,
  - [ ] Editing Makefiles,
  - [ ] Compiling Sourcefiles to produce an Executable Binary,
  - [ ] Understanding the basics of the Linux Shell Environment, and
  - [ ] Understanding the basic tuning required to successfully run a benchmark in your environment.

<div style="page-break-after: always;"></div>

## Network Primer

At the core of High Performance Computing (HPC) is networking. Something as simple as browsing the internet from either your cell phone or the workstation in front of you, involves the transfer and exchange of information between many different networks. Each resource or service connected to the internet is made available through a unique address and network port. For example, https://www.google.co.za:443 is the [Uniform Resource Locator (URL)](https://en.wikipedia.org/wiki/URL) used to uniquely identify Google's search engine page on the South African [co.za]. [domain](https://en.wikipedia.org/wiki/Domain_name). The [443] is the [port number](https://en.wikipedia.org/wiki/Port_(computer_networking)) which in this instance lets you know that you're connecting to a secure [https](https://en.wikipedia.org/wiki/HTTPS) server.

When you enter this address into your browser, one of the first things that will happen is that a [Domain Name Service (DNS)](https://en.wikipedia.org/wiki/Domain_Name_System) will translate the URL [google.co.za] into it's corresponding [Internet Protocol (IP) Address](https://en.wikipedia.org/wiki/IP_address) [142.251.216.67].

A number of [routing](https://en.wikipedia.org/wiki/Router_(computing)) lookup tables will be utilized to determine an available, _and preferably optimal_ path to the resource that you'd requested, thereafter a number of routers or gateway devices will be used to exchange packets between your workstation, through all of the intermediary networks, and finally the target resource. 

At this point it is important to note that even though packets and network traffic are being exchanged between your local workstation and the Google servers, at no point is the private IP Address of your workstation exposed to the external Google Servers. Your workstation would have been assigned a private internal IP Address based on the computer laboratory. Traffic is then routed between the computer laboratory's private internal network and the rest of the university's networks through routers and gateway devices. All the internal computers and components across the campus will appear to the outside as though they have a single public IP address. This is accomplished through a process known as [Network address Translation (NAT)](https://en.wikipedia.org/wiki/Network_address_translation).

<span id="fig2" class="img_container center" style="font-size:8px;margin-bottom:20px; display: block;">
    <img alt="./resources/browsing_internet_dark.png" src="./resources/browsing_internet.png" style="display:block; margin-left: auto; margin-right: auto;" title="caption" />
    <span class="img_caption" style="display: block; text-align: center;margin-top:5px;"><i>Figure 1: Diagram loosely describing process behind browsing to Google.com. You have no information about the computers and servers behind 72.14.222.1, just as Google has no information about your workstation’s internal IP</i></span>
</span>

<div style="page-break-after: always;"></div>

### Basic Networking Example



#### WiFi Hotspot Example
#### WhatIsMyIp.com
### Windows PowerShell Commands
#### `ipconfig`
#### `ping 8.8.8.8`
#### `route print`
#### `tracert`
### Understanding NAT
#### Publicly Accessible IP Address
#### Network Ports
#### Internal Subnet
#### Default Gateway and Routing Table
## Launching your First Open Stack Virtual Machine Instance

### Accessing the CHPC's Cloud

> **! >>>** _In these tutorials, an asterisk ('\*') or a triangle brackets ('\<\>') are placeholders. You will need to fill in the correct information relevant to you. The line `~$` represents that the command following it is to be typed in a terminal and should not be included when typing the command._

In this part, you will be guided through using the ACE Lab's network to gain access to your VMs. You will primarily be using these VMs to do the tutorials. 

1. Open your web browser and visit **cloud.ace.chpc.ac.za**.
2. Use the credentials provided to you to log into the cloud platform ([OpenStack](https://www.openstack.org/)):
   - **<team_name>** for the `Username` and;
   - **<provided_password>** for the `Password`.
3. Once logged in to the web front-end, on the left navigate to `Project` and click `Instances` tab under `Compute`. You will see the VM resources provisioned for you by the ACE Lab.
4. Please note the **IP addresses** assigned to each VM.
    - Your cluster's headnode, **which is one of the VMs**, has two network interfaces attached with 2 unique IP addresses (think of it as having two network ports):
        - An external (public) interface with IP range: **10.128.24.0/24**
        - An internal (private) interface with IP range: **10.0.0.0/24**
        - **The above IP address ranges are specified in [CIDR notation](https://www.ionos.com/digitalguide/server/know-how/cidr-classless-inter-domain-routing/).**
        - The **external network** is **still private** within the ACE Lab, but it can reach the internet through the **gateway address 10.128.24.1**, using a method called **[NAT (Network Address Translation)](https://en.wikipedia.org/wiki/Network_address_translation)** which will be detailed later.
5. Access your VMs via the "Console (VNC)" utility embedded within OpenStack by clicking into one of the VMs listed in the `Compute -> Instances` tab, clicking the name of the VM instance, and navigating to the "Console" tab on the top as shown in [Figure 2](#fig2).

**Hint:** _Your headnode acts as a gateway for your compute nodes using the private virtual network (10.0.0.0/24)._


<span id="fig2" class="img_container center" style="font-size:8px;margin-bottom:20px; display: block;">
    <img alt="test" src="./resources/VNC_icon.png" style="display:block; margin-left: auto; margin-right: auto;" title="caption" />
    <span class="img_caption" style="display: block; text-align: center;margin-top:5px;"><i>Figure 2: The Console (VNC) button and dashboard seen in the OpenStack user interface.</i></span>
</span>

<div style="page-break-after: always;"></div>

### Verify your Teams' Project Workspace

TODO: Screenshot from Workspace : Projects

### Verify your Teams' Available Resources and Launch a New Instance

TODO: Picture of Compute -> Overview
TODO: Picture of Compute -> Instances
TODO: Picture of Compute -> Launch Instance

### Instance Name
### Linux Flavors and Distributions

#### Desktop Usage vs Server

Daily driver

#### Table of Linux Distributions

Explain package managers

| Package Management System | Flavor                                                                                              | Description | Versions Available as Cloud Instances | General Recommendations and Comments |
| ---                       | ---                                                                                                 | ---         | ---                                   | ---                                  |
| RPM                       | [Red Hat Enterprise Linux](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux) |             |                                       |                                      |
|                           | [Rocky Linux](https://rockylinux.org/)                                                              |             |                                       |                                      |
|                           | [Alma Linux](https://almalinux.org/)                                                                |             |                                       |                                      |
|                           | [CentOS Stream](https://www.centos.org/centos-stream/)                                              |             |                                       |                                      |
|                           | [Fedora](https://fedoraproject.org/)                                                                |             |                                       |                                      |
|                           | [OpenSUSE](https://www.opensuse.org/)                                                               |             |                                       |                                      |
| ---                       | ---                                                                                                 | ---         | ---                                   | ---                                  |
| APT                       | [Debian](https://www.debian.org/)                                                                   |             |                                       |                                      |
|                           | [Ubuntu](https://ubuntu.com/)                                                                       |             |                                       |                                      |
|                           | [Linux Mint](https://linuxmint.com/)                                                                |             |                                       |                                      |
|                           | [Pop! OS](https://pop.system76.com/)                                                                |             |                                       |                                      |
|                           | [Kali Linux](https://www.kali.org/)                                                                 |             |                                       |                                      |
| ---                       | ---                                                                                                 | ---         | ---                                   | ---                                  |
| Pacman                    | [Arch Linux](https://archlinux.org/)                                                                |             |                                       |                                      |
|                           | [Manjaro](https://manjaro.org/)                                                                     |             |                                       |                                      |
| ---                       | ---                                                                                                 | ---         | ---                                   | ---                                  |
| Portage                   | [Gentoo](https://www.gentoo.org/)                                                                   |             |                                       |                                      |
| ---                       | ---                                                                                                 | ---         | ---                                   | ---                                  |
| Source-Based              | [Linux From Scratch](https://www.gentoo.org/)                                                       |             |                                       |                                      |
|                           |                                                                                                     |             |                                       |                                      |
 

### OpenStack Instance Flavors

Available resource distribution, headnode vs compute node

#### Compute
#### Memory
#### Storage


### Networks, Ports, Services and Security Groups

### Generating SSH Keys

### Verify that your Instance was Successfully Deployed and Launched

TODO: Picture of Launch Instance
TODO: Picture of Power State Running

### Associating an Externally Available IP Address

TODO: Picture Actions -> Associate Floating IP
TODO: Picture +
TODO: Picture Select Pool
TODO: Associate Floating IP

### Success State, Resource Management and Trouble Shooting
#### Deleting Instances
#### Deleting Volumes
#### Dissociating and Releasing Floating IPs

## Introduction to Basic Linux Administration

### Accessing your VM Using SSH vs the OpenStack Web Console (VNC)

The VMs are running the **CentOS 8 minimal** operating system. This means that they do not contain a graphical environment for you to use a mouse and keyboard with. You will only be able to manipulate the operating system using the command line, or terminal. 

By default, you can only access the VMs using the `root` user account. The default password for this account is **123qwe**.

Use the **[Console (VNC)](https://en.wikipedia.org/wiki/Virtual_Network_Computing)** connection in **OpenStack** to access your VMs for this section.

It is **highly recommended** that you **change your root password** for all of your VMs, as this will prevent unwanted people from getting access to them. This should be done for all of your VMs and not just the head node. You can do so using the `passwd` command.

```bash
~$ passwd
```

Use the command below to list the network interfaces and their current configuration. You will see the names of the interfaces, for example `eth1`, `enp3s0`, or something similar.

```bash
~$ ip a
```

> **! >>> It is important to note here that you will have no IP addresses listed for your network interfaces (such as enp3s0), because they have not been configured yet.**

> **! >>> Ignore and do not count the [**lo**](https://en.wikipedia.org/wiki/Localhost#Loopback) interface!**

<span id="fig3" class="img_container center" style="font-size:8px;margin-bottom:20px; display: block;">
    <img alt="test" src="./resources/ip a.png" style="display:block; margin-left: auto; margin-right: auto;" title="caption" />
    <span class="img_caption" style="display: block; text-align: center;margin-top:5px;"><i>Figure 3: What you should see when you use the "ip a" command.</i></span>
</span>

You can also check the routing table using the command below. Routing is used to allow one network to communicate with another. At this stage, it should be empty since there is not networking configured.

```bash
~$ ip route
```

   > **! >>> This should be empty, as your networks have not yet been configured.**

<div style="page-break-after: always;"></div>


Once you have the network configured correctly on your VMs you can move on to using the `ssh` command to access the VMs via a terminal. To access the VM network, you first need to log in to the ACE Lab's `ssh` server, as mentioned in the [overview section](#overview).

**To recap, the process is:**

```plaintext
1. You are a user trying to connect to your VM from your home or university internet.
2. You use your computer to connect to the ACE Lab login node (ssh.ace.chpc.ac.za).
3. Once logged into the ACE Lab login node, you can then connect to the head node of your virtual cluster.
4. Once connected to the head node of your virtual cluster, you can connect to the compute node of your cluster.
```

#### SSH Through a Linux Terminal

Most Linux distributions already include an `ssh` client via `openssh`. To access this, simply open a terminal session and run the command `ssh` with the parameters necessary for what you want to achieve.

1. Use the credentials that have been provided to you by the ACE Lab to log in to the ssh.ace.chpc.ac.za server.

    ```bash
    [student@home_or_school ~]$ ssh <team_name>@ssh.ace.chpc.ac.za 
    ```

2. Once logged in, from this server run the `ssh` command to the `root` user account of your head node, using the external address **10.128.24.\***, where **\*** is the last digit(s) of your head node's IP address.

    ```bash
    [team_name@ssh ~]$ ssh root@10.128.24.*
    ```

3. The compute node can then be accessed in the same way, but via the head node now, as the **ACE Lab SSH server does not have direct access to the compute node**. Please refer to [Figure 1](#fig1).


#### PuTTY and / or Windows Power Shell

If you are using a **Microsoft Windows** environment you can use a tool called `PuTTY` ([Click here to download](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)) to connect to ssh.ace.chpc.ac.za. With `PuTTY`, steps 2 and 3 should be the same.

Please note that using the command `ssh` or connecting with `PuTTY` creates a new `BASH` shell on the target machine (the machine that you are connecting to). To end this session you must exit. Using the `ssh` command over and over will nest multiple `BASH` shells inside of one another and is not recommended.

<div style="page-break-after: always;"></div>

### Username and Password
### Brief Introduction to Text Editors (Vi vs Vim vs Nano vs Emacs)
### Privilege Escalation and `sudo`
### Linux Binaries, Libraries and Package Management
### Verifying Instance Hostname and `/etc/hosts` File

A hostname is what a computer device is called on a network. These are used to make computer addresses easier to remember. It's a lot easier to remember "**headnode.cluster.scc**" than "**10.0.0.51**"!

To make it easier to distinguish between your head node and your compute node, you should change their hostnames to something logical.

1. Use the `hostnamectl` command to set the new hostname for each machine.

    ```bash
    ~$ hostnamectl set-hostname --static <new_host_name>.cluster.scc
    ```

    A good example would be `headnode.cluster.scc`.
    
    _**This will only reflect once you log out and back into your node! So log out and log back in now.**_

2. In order to access your nodes by hostname rather than IP address (if you **aren't using your own self-controlled DNS server**), you need to populate the `/etc/hosts` file on each machine with the IP address/hostname mappings. 

    This file is used to keep track of static (non-DNS server) hostname/IP mappings. In the `/etc/hosts` file on each of your machines, add the following line:

    ```
    <ip_address_of_machine> <host_name_of_machine>.cluster.scc <host_name_of_machine> 
    ```

    **This order is important for later.**

    **For example**, if we have a head node called "headnode" with an internal (private) network IP of 10.0.0.1, we can use the following:

    ```
    10.0.0.1 headnode.cluster.scc headnode 
    ```

3. You can test connectivity between your two nodes by pinging from one to the other. For example, from your headnode:

    ```bash
    [root@headnode ~]$ ping <compute_node_ip>
    ```

4. Test that you can access your compute node by its hostname:

    ```bash
    [root@headnode ~]$ ssh <compute_node_name>
    ```

At this point your VMs and network should be correctly configured and you can continue with setting up some important Linux services.

<div style="page-break-after: always;"></div>


### Install Dependencies and Fetch Source files for High Performance LinPACK (HPL) Benchmark
#### Install the GNU Compiler Collection (GCC)
#### Install OpenMPI
#### Install ATLAS Math Library
Automatically Tuned Linear Algebra Software
#### Fetch and Extract the HPC Source Tarball
#### Copy and Edit the Makefile for _your_ Target Architecture
### Compile the HPL Source Code to Produce an Executable Binary
#### Editing _your_ PATH Variable
##### Dynamic and Static Libraries: Editing _Your_ ATLAS Shared Object Files
### Configuring _Your_ `HPL.dat` File Using `lscpu` and `lsmem`
