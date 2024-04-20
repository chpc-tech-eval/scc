# CHPC Student Cluster Competition Tutorials

This repository contains the ground truth of information that needs to be covered by the tutorials of the Student Cluster Competition. 

## Table of Contents

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

1. [Overview](#overview)
   1. [Structure of the Tutorials](#/sturture-of-the-tutorials)
   1. [Getting Help](#/getting-help)
1. [Collaborating with your Team and Storing your Progress on GitHub](#/collaborating-with-your-team-and-storing-you-progress-on-github)
   1. [Forking the Tutorials into Your Own Team's Private Git Repository](#/forking-the-tutorials-into-your-own-teams-private-github-repository)
      1. [Branch, Merge and Pull Requests to your Team Captain's Repository]()
      1. [Editing the Git Markdown Files to Track Your Team's Progress](#/editing-the-git-markdown-files-to-track-your-teams-progress)
1. [Contributing to the Project](#/contributing-to-the-project)
   1. [Raising Issues and Reporting Bugs with the Tutorial Content]()
   1. [Submitting Pull Requests for Features / Bug Fixes]()
      1. [Steps to follow when editing content]()
1. [Tutorial 1](#/tutorial-1)

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

### Dark and Light Themes
Syntax for light themes add to image addition
```shell
![Termux Logo](https://user-images.githubusercontent.com/72879799/153904003-d7dee710-6552-4d23-a803-7a9a0ba67d92.png#gh-dark-mode-only)
![Termux Logo](https://user-images.githubusercontent.com/72879799/153904095-9d78a019-8495-4035-8174-e3da8e4dd66b.png#gh-light-mode-only)
```

TODO: Fix links

## Tutorial 1

Tutorial 1 deals with introducing concepts to users and getting them started with using the virtual lab, setting up networking and remotely connecting. The content is as follows:

1. [Overview](Tutorial_1/README.md#overview)
1. [Network Primer](Tutorial_1/README.md#network-primer)
   1. [Internal Intranet vs External Internet](Tutorial_1/README.md#internal-intranet-vs-external-internet)
      1. [WiFi Hotspot Example](Tutorial_1/README.md#wifi-hotspot-example)
      1. [WhatIsMyIp.com](Tutorial_1/README.md#whatismyipcom)
   1. [Windows PowerShell Commands](Tutorial_1/README.md#windows-powershell-commands)
      1. [`ipconfig`](Tutorial_1/README.md#ipconfig)
      1. [`ping 8.8.8.8`](Tutorial_1/README.md#ping-8888)
      1. [`route print`](Tutorial_1/README.md#route-print)
      1. [`tracert`](Tutorial_1/README.md#tracert)
   1. [Understanding NAT](Tutorial_1/README.md#understanding-nat)
      1. [Publicly Accessible IP Address](Tutorial_1/README.md#publicly-accessible-ip-address)
      1. [Network Ports](Tutorial_1/README.md#network-ports)
      1. [Internal Subnet](Tutorial_1/README.md#internal-subnet)
      1. [Default Gateway and Routing Table](Tutorial_1/README.md#default-gateway-and-routing-table)
1. [Launching your First Open Stack Virtual Machine Instance](Tutorial_1/README.md#launching-your-first-open-stack-virtual-machine-instance)
   1. [Accessing the CHPC's Cloud](Tutorial_1/README.md#accessing-the-chpcs-cloud)
   1. [Verify your Teams' Project Workspace](Tutorial_1/README.md#verify-your-teams-project-workspace)
   1. [Verify your Teams' Available Resources and Launch a New Instance](Tutorial_1/README.md#verify-your-teams-available-resources-and-launch-a-new-instance)
   1. [Instance Name](Tutorial_1/README.md#instance-name)
   1. [Linux Flavors and Distributions](Tutorial_1/README.md#linux-flavors-and-distributions)
      1. [Desktop Usage vs Server](Tutorial_1/README.md#desktop-usage-vs-server)
      1. [Table of Linux Distributions](Tutorial_1/README.md#table-of-linux-distributions)
   1. [OpenStack Instance Flavors](Tutorial_1/README.md#openstack-instance-flavors)
      1. [Compute](Tutorial_1/README.md#compute)
      1. [Memory](Tutorial_1/README.md#memory)
      1. [Storage](Tutorial_1/README.md#storage)
   1. [Networks, Ports, Services and Security Groups](Tutorial_1/README.md#networks-ports-services-and-security-groups)
   1. [Generating SSH Keys](Tutorial_1/README.md#generating-ssh-keys)
   1. [Verify that your Instance was Successfully Deployed and Launched](Tutorial_1/README.md#verify-that-your-instance-was-successfully-deployed-and-launched)
   1. [Associating an Externally Available IP Address](Tutorial_1/README.md#associating-an-externally-available-ip-address)
   1. [Success State, Resource Management and Trouble Shooting](Tutorial_1/README.md#success-state-resource-management-and-trouble-shooting)
      1. [Deleting Instances](Tutorial_1/README.md#deleting-instances)
      1. [Deleting Volumes](Tutorial_1/README.md#deleting-volumes)
      1. [Dissociating and Releasing Floating IPs](Tutorial_1/README.md#dissociating-and-releasing-floating-ips)
1. [Introduction to Basic Linux Administration](Tutorial_1/README.md#introduction-to-basic-linux-administration)
   1. [Accessing your VM Using SSH vs the OpenStack Web Console (VNC)](Tutorial_1/README.md#accessing-your-vm-using-ssh-vs-the-openstack-web-console-vnc)
      1. [SSH Through a Linux Terminal](Tutorial_1/README.md#ssh-through-a-linux-terminal)
      1. [PuTTY and / or Windows Power Shell](Tutorial_1/README.md#putty-and--or-windows-power-shell)
   1. [Username and Password](Tutorial_1/README.md#username-and-password)
   1. [Brief Introduction to Text Editors (Vi vs Vim vs Nano vs Emacs)](Tutorial_1/README.md#brief-introduction-to-text-editors-vi-vs-vim-vs-nano-vs-emacs)
   1. [Privilege Escalation and `sudo`](Tutorial_1/README.md#privilege-escalation-and-sudo)
   1. [Linux Binaries, Libraries and Package Management](Tutorial_1/README.md#linux-binaries-libraries-and-package-management)
   1. [Verifying Instance Hostname and `/etc/hosts` File](Tutorial_1/README.md#verifying-instance-hostname-and-etchosts-file)
1. [Install Dependencies and Fetch Source files for High Performance LinPACK (HPL) Benchmark](Tutorial_1/README.md#install-dependencies-and-fetch-source-files-for-high-performance-linpapl-benchmark)
   1. [Install the GNU Compiler Collection (GCC)](Tutorial_1/README.md#install-the-gnu-compiler-collection-gcc)
   1. [Install OpenMPI](Tutorial_1/README.md#install-openmpi)
   1. [Install ATLAS Math Library](Tutorial_1/README.md#install-atlas-math-library)
   1. [Fetch and Extract the HPC Source Tarball](Tutorial_1/README.md#fetch-and-extract-the-hpc-source-tarball)
   1. [Copy and Edit the Makefile for _your_ Target Architecture](Tutorial_1/README.md#copy-and-edit-the-makefile-for-_your_-target-architecture)
1. [Compile the HPL Source Code to Produce an Executable Binary](Tutorial_1/README.md#compile-the-hpl-source-code-to-produce-an-executable-binary)
   1. [Editing _your_ PATH Variable](Tutorial_1/README.md#editing-_your_-path-variable)
      1. [Dynamic and Static Libraries: Editing _Your_ ATLAS Shared Object Files](Tutorial_1/README.md#dynamic-and-static-libraries-editing-_your_-atlas-shared-object-files)
   1. [Configuring _Your_ `HPL.dat` File Using `lscpu` and `lsmem`](Tutorial_1/README.md#configuring-_your_-hpldat-file-using-lscpu-and-lsmem)
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
