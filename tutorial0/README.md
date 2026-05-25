# Tutorial 0: Setting Up a Virtual Environment with UTM on macOS

This tutorial introduces the basics of virtual computing and guides you through setting up a small virtual cluster using **UTM** on macOS.

UTM is a virtualization and emulation application designed for macOS, with excellent support for Apple Silicon devices (M1/M2/M3/M4). It allows you to run multiple virtual machines using both ARM and x86 architectures.

A virtual machine (VM) is a software-based computer that runs inside your physical machine. Each VM has its own operating system, storage, networking, and applications, and behaves like an independent computer.

In this tutorial, you will use UTM to create multiple Linux virtual machines and connect them into a small cluster environment. This setup will form the foundation for later tutorials involving networking, distributed computing, and benchmarking.

## Prerequisites

Before starting this tutorial, ensure that you have:

- A macOS device ( M1/M2/M3/M4)
- UTM installed on your machine
- Basic familiarity with using the terminal

---

# Table of Contents

1. [Checklist](#checklist)
2. [Install UTM](#install-utm)
   1. [Download UTM](#download-utm)
3. [UTM Overview](#utm-overview)
   1. [Networking](#networking)
4. [Create a New VM](#create-a-new-vm)
5. [Operating System](#operating-system)
6. [Download Preferred OS](#download-preferred-os)
7. [Mount and Install](#mount-and-install)
8. [Setup Cluster](#setup-cluster)

---

# Checklist

<u>Use the following checklist to keep track of your team's progress and ensure all members understand the concepts.</u>

- [ ] Understand virtual computing, virtualization, and remote connections:
  - [ ] Understand and explain virtualization and virtual machines
  - [ ] Understand the difference between Shared Network, Bridged, and Host networking
- [ ] Learn how to install an Operating System (OS):
  - [ ] Learn about different Linux distributions and flavors
- [ ] Learn how to setup a cluster using UTM:
  - [ ] Learn how to connect multiple machines together

---

# Install UTM

## Download UTM

Head to your preferred search engine and search for **"UTM download"**.

Download UTM from the official website:

https://mac.getutm.app/

You can also download it from the Mac App Store if preferred.

---

## Install UTM

1. Open the downloaded `.dmg` file
2. Drag **UTM.app** into the **Applications** folder
3. Launch UTM

You may be prompted to allow additional permissions for virtualization.

---

# UTM Overview

Below are the key areas of the UTM interface:

1. Virtual Machines List
2. Create New VM
3. VM Settings
4. Start / Stop VM
5. Network Configuration
6. Storage and Drives

---

# Networking

There are several networking modes available in UTM. Understanding these is important for cluster setup.

## 1. Shared Network (Recommended)

This is the default NAT-style network.

- Provides internet access to the VM
- VM can access the outside internet
- Simplest and safest option
- Similar to VirtualBox NAT mode

Use this for:
- Package downloads
- Internet access
- General usage

---

## 2. Bridged Network

Bridged mode places the VM directly onto your physical network.

- VM receives an IP from your router
- VM behaves like a real machine on your network
- Other devices can directly access the VM

Be careful when using bridged mode.

For example:
- Misconfigured services like DHCP servers can affect your home or office network

---

## 3. Host Network / Internal Network

This allows VMs to communicate with each other privately.

- No internet access by default
- Useful for building clusters
- Similar to an internal switch

Use this for:
- Headnode ↔ Compute node communication
- Cluster traffic
- Testing distributed systems

---

# Create a New VM

Open UTM and select:

**Create a New Virtual Machine**

---

## Choose Virtualization Type

For Apple Silicon Macs:

- Select **Virtualize**
- Choose **Linux**

For Intel Macs:

- You may use either **Virtualize** or **Emulate**

---

## Select ISO Image

Browse and select your downloaded Linux ISO.

---

## Configure Hardware

Choose suitable resources based on your Mac specifications.

Recommended starter setup:

| Resource | Recommended |
|---|---|
| CPU | 2–4 Cores |
| RAM | 4–8 GB |
| Storage | 20–40 GB |

Remember:
- Your VMs share resources with your host machine
- Avoid allocating all available memory or CPU

---

## Configure Storage

The default storage settings are usually acceptable.

You can resize storage later if needed.

---

# Operating System

After creating the VM:

1. Start the VM
2. The Linux installer will boot from the ISO
3. Follow the installation process

---

# Download Preferred OS

You can browse Linux distributions here:

https://www.linux.org/pages/download/

Recommended beginner-friendly options:

- Ubuntu
- Rocky Linux

For Apple Silicon Macs:
- Ensure you download the **ARM64 / AArch64** version of the ISO

Example:
- Ubuntu Server ARM64
- Rocky Linux AArch64

Do NOT download AMD64 images on Apple Silicon Macs.

---

# Mount and Install

Once the ISO is attached:

1. Start the VM
2. Complete the Linux installation
3. Create a username and password
4. Reboot the VM after installation
5. Remove the ISO if prompted

---

# Setup Cluster

You are now ready to create additional VMs and build a simple cluster.

---

# Suggested Cluster Layout

| Machine | Network Adaptor 1 | Network Adaptor 2 |
|---|---|---|
| Headnode | Shared Network | Internal Network |
| Compute Node 1 | Internal Network | — |
| Compute Node 2 | Internal Network | — |

---

# Configure Headnode Networking

Your headnode should have:

1. Shared Network adaptor
2. Internal Network adaptor

The Shared adaptor provides internet access.

The Internal adaptor connects to compute nodes.

---

# Configure Internal Network

In the VM settings:

1. Open **Network**
2. Add a second network interface
3. Configure it as:
   - **Mode:** Host or Internal
   - **Network Name:** `cluster-net`

Use the exact same network name on all VMs.

---

# Configure Compute Nodes

Each compute node only requires:

- One Internal/Host network adaptor connected to `cluster-net`

Once connected:
- The VMs can communicate directly

---

# Configure IP Addresses

You can manually configure IP addresses on each VM.

Example:

| Machine | IP Address |
|---|---|
| Headnode | 10.10.10.1 |
| Compute1 | 10.10.10.2 |
| Compute2 | 10.10.10.3 |

---

# Final Notes

Once networking is configured correctly:

- Your VMs will be able to communicate
- You can SSH between nodes
- You can begin experimenting with clustering technologies such as:
  - Kubernetes
  - Docker Swarm
  - OpenStack
  - Ceph
  - MPI Clusters

You now have a functional virtual lab environment running on macOS using UTM.
