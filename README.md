# CHPC Student Cluster Competition Tutorials

This repository contains the information that will be covered by the tutorials of the Student Cluster Competition. 

## Table of Contents

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

1. [Overview](#overview)
   1. [Structure of the Tutorials](#sturture-of-the-tutorials)
   1. [Getting Help](#getting-help)
1. [Collaborating with your Team and Storing your Progress on GitHub](#collaborating-with-your-team-and-storing-you-progress-on-github)
   1. [Forking the Tutorials into Your Own Team's Private Git Repository](#forking-the-tutorials-into-your-own-teams-private-github-repository)
      1. [Branch, Merge and Pull Requests to your Team Captain's Repository]()
      1. [Editing the Git Markdown Files to Track Your Team's Progress](#editing-the-git-markdown-files-to-track-your-teams-progress)
1. [Glossary and Section Overview](#glossary-and-section-overview)
   1. [Tutorial 1](#tutorial-1)
   1. [Tutorial 2](#tutorial-2)
   1. [Tutorial 3](#tutorial-3)
   1. [Tutorial 4](#tutorial-4)
1. [Contributing to the Project](#contributing-to-the-project)
   1. [Raising Issues and Reporting Bugs with the Tutorial Content]()
   1. [Submitting Pull Requests for Features / Bug Fixes]()
      1. [Steps to follow when editing content]()
<!-- markdown-toc end -->

## Overview

Welcome the **Center for High Performance Computing (CHPC)'s Student Cluster Competition (SCC)** - Team Selection Round. This round requires each team to build a **prototype compute cluster** in the ACE Lab's **virtual compute cloud** (described below).

The goal of this tutorial is to introduce you to the competition platform and familiarise you with some Linux and systems administration concepts.

<u>Please note the following concepts:</u>

- **[Cloud computing](https://en.wikipedia.org/wiki/Cloud_computing)** is the **on-demand** delivery of **I.T. services** by a first-party (you) or third-party (external) provider over a network, possibly including the **internet**. This can allow you to access computing or other I.T. services wherever you are and at your convenience.
- **[Infrastructure as a Service (IaaS)](https://en.wikipedia.org/wiki/Infrastructure_as_a_service)** is where physical or virtual hardware is presented to a user, but the user is not exposed to the underlying technology. In other words, this competition provides you with an IaaS experience by giving you a set of virtual machines that you can use for the competition. You cannot control the cloud environment that the virtual machines are provided on.
- **Instances ([virtual machines](https://en.wikipedia.org/wiki/Virtual_machine) or 'VMs')** are software copies of virtual computers that are hosted within a physical computer (the **['host'](https://en.wikipedia.org/wiki/Host_(network))**). The host provides access to one or more virtual computers at the same time. This competition provides you with a fixed set of virtual resources, that you will use to initialize a set a set of virtual machines instances based on your choice _or flavor_ of **[Linux Operating System Distributions](https://en.wikipedia.org/wiki/List_of_Linux_distributions)**.

### Structure of the Tutorials

### Getting Help

## Collaborating with your Team and Storing you Progress on GitHub

### Forking the Tutorials into Your Own Team's Private GitHub Repository

### Editing the Git Markdown Files to Track Your Team's Progress

TODO: Add objectives for each Tutorial and section. They should be editable so students check them off as they go along.

## Glossary and Section Overview

### Tutorial 1

Tutorial 1 deals with introducing concepts to users and getting them started with using the virtual lab, setting up networking and remotely connecting. The content is as follows:

1. [Overview](Tutorial_1/README.md#overview)
1. [Network Primer](Tutorial_1/README.md#network-primer)
   1. [Basic Networking Example (WhatIsMyIp.com)](Tutorial_1/README.md#basic-networking-example-whatismyipcom)
      1. [Local WiFi Network](Tutorial_1/README.md#local-wifi-network)
      1. [External Cellular Network](Tutorial_1/README.md#external-cellular-network)
      1. [WiFi Hotspot Example](Tutorial_1/README.md#wifi-hotspot-example)
   1. [Windows PowerShell Commands](Tutorial_1/README.md#windows-powershell-commands)
      1. [`ipconfig`](Tutorial_1/README.md#ipconfig)
      1. [`ping 8.8.8.8`](Tutorial_1/README.md#ping-8888)
      1. [`route print`](Tutorial_1/README.md#route-print)
      1. [`tracert`](Tutorial_1/README.md#tracert)
1. [Launching your First Open Stack Virtual Machine Instance](Tutorial_1/README.md#launching-your-first-open-stack-virtual-machine-instance)
   1. [Accessing the CHPC's Cloud](Tutorial_1/README.md#accessing-the-chpcs-cloud)
   1. [Verify your Teams' Project Workspace](Tutorial_1/README.md#verify-your-teams-project-workspace)
   1. [Generating SSH Keys](Tutorial_1/README.md#generating-ssh-keys)
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

### Tutorial 2

Tutorial 2 deals with reverse proxy access for internal websites, central authentication and shared file systems.

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

TODO: Add objectives for each Tutorial and section. They should be editable so students check them off as they go along.
