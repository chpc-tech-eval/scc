# CHPC Student Cluster Competition Tutorials

This repository contains the ground truth of information that needs to be covered by the tutorials of the Student Cluster Competition. 

## Table of Contents

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

1. [Overview](#overview)
   1. [Structure of the Tutorials](#tutorial-1/sturture-of-the-tutorials)
   1. [Getting Help](#tutorial-1/getting-help)
1. [Collaborating with your Team and Storing your Progress on GitHub](#tutorial-1/collaborating-with-your-team-and-storing-you-progress-on-github)
   1. [Forking the Tutorials into Your Own Team's Private Git Repository](#tutorial-1/forking-the-tutorials-into-your-own-teams-private-github-repository)
      1. [Branch, Merge and Pull Requests to your Team Captain's Repository]()
      1. [Editing the Git Markdown Files to Track Your Team's Progress](#tutorial-1/editing-the-git-markdown-files-to-track-your-teams-progress)
1. [Contributing to the Project](#tutorial-1/contributing-to-the-project)
   1. [Raising Issues and Reporting Bugs with the Tutorial Content]()
   1. [Submitting Pull Requests for Features / Bug Fixes]()
      1. [Steps to follow when editing content]()
1. [Tutorial 1](#tutorial-1/tutorial-1)
1. [Overview](#tutorial-1/overview)
1. [Network Primer](#tutorial-1/network-primer)
   1. [Internal Intranet vs External Internet](#tutorial-1/internal-intranet-vs-external-internet)
      1. [WiFi Hotspot Example](#tutorial-1/wifi-hotspot-example)
      1. [WhatIsMyIp.com](#tutorial-1/whatismyipcom)
      1. [Windows PowerShell Commands](#tutorial-1/windows-powershell-commands)
         1. [`ipconfig`](#tutorial-1/ipconfig)
         1. [`ping 8.8.8.8`](#tutorial-1/ping-8888)
         1. [`route print`](#tutorial-1/route-print)
         1. [`tracert`](#tutorial-1/tracert)
      1. [Understanding NAT](#tutorial-1/understanding-nat)
         1. [Publicly Accessible IP Address](#tutorial-1/publicly-accessible-ip-address)
         1. [Network Ports](#tutorial-1/network-ports)
         1. [Internal Subnet](#tutorial-1/internal-subnet)
         1. [Default Gateway and Routing Table](#tutorial-1/default-gateway-and-routing-table)
1. [Launching your First Open Stack Virtual Machine Instance](#tutorial-1/launching-your-first-open-stack-virtual-machine-instance)
   1. [Accessing the CHPC's Cloud](#tutorial-1/accessing-the-chpcs-cloud)
   1. [Verify your Teams' Project Workspace](#tutorial-1/verify-your-teams-project-workspace)
   1. [Verify your Teams' Available Resources and Launch a New Instance](#tutorial-1/verify-your-teams-available-resources-and-launch-a-new-instance)
   1. [Instance Name](#tutorial-1/instance-name)
   1. [Linux Flavors and Distributions](#tutorial-1/linux-flavors-and-distributions)
      1. [Desktop Usage vs Server](#tutorial-1/desktop-usage-vs-server)
      1. [Table of Linux Distributions](#tutorial-1/table-of-linux-distributions)
   1. [OpenStack Instance Flavors](#tutorial-1/openstack-instance-flavors)
      1. [Compute](#tutorial-1/compute)
      1. [Memory](#tutorial-1/memory)
      1. [Storage](#tutorial-1/storage)
  1. [Networks, Ports, Services and Security Groups](#tutorial-1/networks-ports-services-and-security-groups)
  1. [Generating SSH Keys](#tutorial-1/generating-ssh-keys)
  1. [Verify that your Instance was Successfully Deployed and Launched](#tutorial-1/verify-that-your-instance-was-successfully-deployed-and-launched)
  1. [Associating an Externally Available IP Address](#tutorial-1/associating-an-externally-available-ip-address)
  1. [Success State, Resource Management and Trouble Shooting](#tutorial-1/success-state-resource-management-and-trouble-shooting)
     1. [Deleting Instances](#tutorial-1/deleting-instances)
     1. [Deleting Volumes](#tutorial-1/deleting-volumes)
     1. [Dissociating and Releasing Floating IPs](#tutorial-1/dissociating-and-releasing-floating-ips)
1. [Introduction to Basic Linux Administration](#tutorial-1/introduction-to-basic-linux-administration)
   1. [Accessing your VM Using SSH vs the OpenStack Web Console (VNC)](#tutorial-1/accessing-your-vm-using-ssh-vs-the-openstack-web-console-vnc)
      1. [SSH Through a Linux Terminal](#tutorial-1/ssh-through-a-linux-terminal)
      1. [PuTTY and / or Windows Power Shell](#tutorial-1/putty-and--or-windows-power-shell)
   1. [Username and Password](#tutorial-1/username-and-password)
   1. [Brief Introduction to Text Editors (Vi vs Vim vs Nano vs Emacs)](#tutorial-1/brief-introduction-to-text-editors-vi-vs-vim-vs-nano-vs-emacs)
   1. [Privilege Escalation and `sudo`](#tutorial-1/privilege-escalation-and-sudo)
   1. [Linux Binaries, Libraries and Package Management](#tutorial-1/linux-binaries-libraries-and-package-management)
   1. [Verifying Instance Hostname and `/etc/hosts` File](#tutorial-1/verifying-instance-hostname-and-etchosts-file)
1. [Install Dependencies and Fetch Source files for High Performance LinPACK (HPL) Benchmark](#tutorial-1/install-dependencies-and-fetch-source-files-for-high-performance-linpapl-benchmark)
   1. [Install the GNU Compiler Collection (GCC)](#tutorial-1/install-the-gnu-compiler-collection-gcc)
   1. [Install OpenMPI](#tutorial-1/install-openmpi)
   1. [Install ATLAS Math Library](#tutorial-1/install-atlas-math-library)
   1. [Fetch and Extract the HPC Source Tarball](#tutorial-1/fetch-and-extract-the-hpc-source-tarball)
   1. [Copy and Edit the Makefile for _your_ Target Architecture](#tutorial-1/copy-and-edit-the-makefile-for-_your_-target-architecture)
1. [Compile the HPL Source Code to Produce an Executable Binary](#tutorial-1/compile-the-hpl-source-code-to-produce-an-executable-binary)
   1. [Editing _your_ PATH Variable](#tutorial-1/editing-_your_-path-variable)
      1. [Dynamic and Static Libraries: Editing _Your_ ATLAS Shared Object Files](#tutorial-1/dynamic-and-static-libraries-editing-_your_-atlas-shared-object-files)
   1. [Configuring _Your_ `HPL.dat` File Using `lscpu` and `lsmem`](#configuring-_your_-hpldat-file-using-lscpu-and-lsmem)

1. [Tutorial 2](#tutorial-2)
1. [Tutorial 3](#tutorial-3)
1. [Tutorial 4](#tutorial-4)
<!-- markdown-toc end -->

## Overview

### Structure of the Tutorials

### Getting Help

## Collaborating with your Team and Storing you Progress on GitHub

### Forking the Tutorials into Your Own Team's Private GitHub Repository

### Editing the Git Markdown Files to Track Your Team's Progress

## Contributing to the Project

#### Steps to follow when editing existing content

1. `git clone` a local copy of the repository, to your personal work space.
1. Create a new branch to work on. i.e. `git branch tutX_rework` followed by `git checkout tutX_rework`, or simply use a single command `git checkout -b tutX_rework`.
   - Give the branch a sensible name.
   - You are encouraged to push the branch back upstream so that collaborators can see what you are working on as you make the changes.
   - Should you want to make relatively small and quick changes to someone else's feature, then you should branch their branch, and merge that feature, back into that branch before they merge their branch back into main. i.e. `git checkout -b tutX_rework_fixed_typo`.
1. Make the appropriate changes.
1. `git add <relative_path_to_changed_file(s)>`
1. `git commit -m "some_message_pertaining_to_changes_made"`
1. Push your changes, back upstream to the branch you are currently working on `git push`.
1. Once you are satisfied with the changes you've have been editing, eliminate all merge conflicts by pulling all upstream changes and deviations into your local working copy. `git pull`.
   - If you are confident that your feature does or has not deviated from the upstream `main` branch, use `git pull` to automatically `fetch` and `merge` upstream changes from main into your feature branch.
   - Alternatively, if your branch is old, or depends on / requires changes from upstream use `git fetch`, to `fetch` upstream changes and be able to preview them before merging. 
   - Eliminate your local conflicts and merge all upstream changes `git merge`.
   - Once all the conflicts have been resolved, and you've successfully merged all upstream changes, push your branch upstream.
1. Create a pull request to the upstream main branch, to incorporate your feature.

### Syntax and Style

Use the following guide on [Github Markdown Syntax Editing](https://docs.github.com/en/get-started/writing-on-.)

Make use of the following editing features of Github markdown
> [!NOTE]
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]
> Crucial information necessary for users to succeed.

> [!WARNING]
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.

### Foldable Code Blocks

For different commands, flavors or options, tabbed source code block are not available to use fordable blocks instead:
<details>
<summary>Tips for collapsed sections</summary>

### You can add a header

You can add text within a collapsed section. 

You can add an image or a code block, too.

```ruby
   puts "Hello World"
```
</details>

<details>
<summary>RHEL Based Systems</summary>

```bash
   $ sudo dnf install package X
```

</details>

<details>
<summary>Debian Based Systems</summary>

```sh
   $ sudo apt-get install lib_package-X
```

</details>


## Tutorial 1

Tutorial 1 deals with introducing concepts to users and getting them started with using the virtual lab, setting up networking and remotely connecting. The content is as follows:

### Part 1 - Overview
- [x] Introduce cloud computing
- [x] Introduce IaaS
- [x] Introduce instances
- [x] Describe ACE Lab and virtual lab network
- [x] Discuss accessing ACE Lab virtual lab (ssh and VNC)

### Part 2 - Detail accessing the virtual lab
- [x] Detail how to access virtual instances and how to use VNC

### Part 3 - IP Addressing and routing
- [x] Provide username/password to students
- [x] Describe how to check IP information and routing
- [x] Describe how to change IP addressing (sysconfig) and set changes
- [x] Introduce and detail how to use ssh to access virtual lab
    - [x] Linux
    - [x] Windows (PuTTY)

### Part 4 - Firewall
- [x] Introduce `firewalld`
- [x] Introduce NAT
- [x] Explain `ping` tool
- [x] Describe `/etc/resolv.conf` and DNS

### Part 5 - Hostnames/DNS
- [x] Introduce `hostnamectl` for changing hostname
- [x] Introduce and explain `/etc/hosts`
- [x] Test hostname connectivity

### Part 6 - NTP
- [x] Explain NTP
- [x] Install and configure `ntp` on all nodes

## Tutorial 2

Tutorial 2 deals with reverse proxy access for internal websites, central authentication and shared file systems.

### Part 1 - Reverse Proxy
- [x] Install and start a web-server 
- [x] Demonstrate a tunnel using `ssh` and instruct student to load the website on their local machine

### Part 2 - LDAP
- [x] Describe LDAP to the student
- [x] Server setup
  - [x] List dependencies for `openldap`
  - [x] Demonstrate the configuration of ldap
  - [x] Generate an SSL cert and add that to ldap server
  - [x] Install LDAP Account Manager
  - [x] Set up LDAP account manager
  - [x] Create users and admins groups
  - [x] Create user for students
- [x] Client setup
  - [x] Install dependencies
  - [x] `authconfig-tui` for setting up LDAP on all nodes
  - [x] Test LDAP connections on all machines

### Part 3 - NFS
- [x] Describe NFS to user and explain it's usefulness
- [x] Server setup
  - [x] Install nfs service
  - [x] set up NFS args `/etc/sysconfig/nfs`
  - [x] export home directory
  - [x] restart nfs
- Compute node
  - [x] add to fstab
  - [x] mount 
- [x] perform ssh keyless pass

## Tutorial 3

Tutorial 3 ......

### Part 1 - Monitoring With Zabbix
  - [x] Install And Configure The Zabbix Server On The Head Node
  - [x] Zabbix Server Setup
    - [x] Zabbix Web Interface Setup
      - [x] System Configuration
      - [x] Web Interface Configuration
  - [x] Install And Configure The Zabbix Agent
  - [x] Monitoring Your Infrastructure

  ### Part 2 - Slurm Workload Manager
  - [x] Prerequisites
  - [x] Server Setup
  - [x] Client Setup
