# Tutorial 0: Setting Up a Virtual Environment with UTM on macOS

This tutorial introduces the basics of virtual computing and guides you through setting up a small virtual cluster using **UTM** on macOS.

UTM is a virtualization and emulation application designed for macOS, with excellent support for Apple Silicon devices (M1/M2/M3/M4). It allows you to run multiple virtual machines using both ARM and x86 architectures.

A virtual machine (VM) is a software-based computer that runs inside your physical machine. Each VM has its own operating system, storage, networking, and applications, and behaves like an independent computer.

In this tutorial, you will use UTM to create multiple Linux virtual machines and connect them into a small cluster environment. This setup will form the foundation for later tutorials involving networking, distributed computing, and benchmarking.

---

## Prerequisites

Before starting this tutorial, ensure that you have:

- A macOS device (M1/M2/M3/M4)

- UTM installed on your machine

- Basic familiarity with using the terminal

- Enough free disk space for multiple virtual machines

- Enough memory to run more than one VM at the same time



---

## Table of Contents

1. [Checklist](#checklist)

2. [Install UTM](#install-utm)

3. [Download Operating System](#download-operating-system)

4. [Create and Install Your Headnode VM](#create-and-install-your-headnode-vm)

5. [Understanding Networking](#understanding-networking)

6. [Expand the Headnode into a Cluster](#expand-the-headnode-into-a-cluster)

7. [Suggested Cluster Layout](#suggested-cluster-layout)

8. [Configure Networking in UTM](#configure-networking-in-utm)

9. [Configure IP Addresses](#configure-ip-addresses)

10. [Final Notes](#final-notes)

---

## Checklist

Use the following checklist to track progress:

- [ ] Understand what a virtual machine is

- [ ] Install UTM successfully

- [ ] Download a Linux operating system ISO

- [ ] Create and install your first VM

- [ ] Understand that the first VM will become the headnode

- [ ] Add a private/internal network interface to the headnode

- [ ] Create additional compute node VMs

- [ ] Connect all nodes using a private network

- [ ] Configure static IP addresses

- [ ] Confirm that all nodes can communicate

---

## Install UTM

### Download UTM

Download UTM from the official website:

https://mac.getutm.app/

You can also download it from the Mac App Store if preferred.

---

### Install UTM

1. Open the downloaded `.dmg` file

2. Drag **UTM.app** into the **Applications** folder

3. Launch UTM

You may be prompted to allow permissions for virtualization.

---

## Download Operating System

Before creating a virtual machine, you need a Linux installation file called an **ISO image**.

An ISO image is a file that contains everything needed to install an operating system, similar to a virtual installation disk.

Browse Linux distributions here:

https://www.linux.org/pages/download/

### Recommended options

- Ubuntu

- Rocky Linux

Ubuntu is beginner-friendly.

Rocky Linux is more enterprise-like and is closer to what you may see in server, cloud, and HPC environments.

---

### Important for Apple Silicon Users
> [!IMPORTANT]
> If you are using an M1/M2/M3/M4 Mac, download the **ARM64 / AArch64** version of the operating system.
>
> **Examples:**
> - Ubuntu Server ARM64  
> - Rocky Linux AArch64  
>
> **Do NOT download:**
> - AMD64  
> - x86_64  
>
> These are designed for Intel/AMD machines and may not boot correctly on Apple Silicon.

---

## Create and Install Your Headnode VM

In this section, you will create your first virtual machine. This VM will become your **headnode**. The headnode is the main machine in the cluster. It is usually used to manage the cluster, connect to other machines, and coordinate work between compute nodes.

At this stage, you do not need to configure the full cluster network yet. The goal is to first create one working Linux VM.

---

### Step 1: Create a New VM

1. Open UTM

2. Click **Create New Virtual Machine**

### Step 1: Create a New VM

1. Open UTM  
2. Click **Create New Virtual Machine**

<img width="1074" height="799" alt="Screenshot 2026-05-25 at 14 57 43" src="https://github.com/user-attachments/assets/8de4ebed-cc89-4dc9-aa31-153f35c50343" />


3. Select **Virtualize**

<img width="1069" height="794" alt="Screenshot 2026-05-25 at 15 01 59" src="https://github.com/user-attachments/assets/1ac4fa5d-02d6-4fc4-95a2-eece28b7ceb7" />


4. Select **Linux**

Use **Virtualize** on Apple Silicon Macs because it provides better performance than emulation when using an ARM64/AArch64 operating system.

<img width="1068" height="780" alt="Screenshot 2026-05-25 at 15 03 00" src="https://github.com/user-attachments/assets/24534c63-c3e7-4640-bc49-bb8e4db7537f" />


---

### Step 2: Select ISO Image

Browse and select the Linux ISO file you downloaded earlier.

<img width="453" height="504" alt="Screenshot 2026-05-25 at 15 04 12" src="https://github.com/user-attachments/assets/bc244ccc-ca1e-4b7c-be5d-712fcd58b57b" />


This ISO will be used to install Linux onto the virtual machine.

---

### Step 3: Configure Hardware Resources

Choose suitable resources based on your Mac specifications.

Use the following as a starting point:

| Resource | Recommended |
|----------|-------------|
| CPU      | 2–4 Cores   |
| RAM      | 4–8 GB      |
| Storage  | 20–40 GB    |

Your VM shares resources with your Mac.

Do not allocate all available CPU cores or memory to the VM, because your Mac still needs resources to run macOS and UTM.

For example, if your Mac has 8 GB of RAM, do not assign all 8 GB to the VM.

---

### Step 4: Configure the Initial Network

For the first VM setup, use:

| Setting               | Value             |
|----------------------|------------------|
| Network Mode         | Shared Network   |
| Emulated Network Card| virtio-net-pci   |

The **Shared Network** gives your VM internet access. This is useful for downloading packages and updates.

The **virtio-net-pci** network card is recommended because it is efficient and commonly used in virtualized Linux environments.

At this stage, your headnode only needs one network interface. Later, you will add a second private/internal network interface for cluster communication.

---

### Step 5: Create the VM

Complete the setup and create the virtual machine.

You may name it:

```text

headnode

```

Using clear names is helpful later when you create multiple machines.

---

### Step 6: Install Linux

1. Start the VM
2. The Linux installer should boot from the ISO
3. Follow the installation steps
4. Select your language and keyboard settings
5. Create a username and password
6. Complete the installation

If the installer requires a root password or an administrator user, make sure you set one.

---

### Step 7: Reboot and Eject the ISO

After installation:

1. Reboot the VM
2. Remove or eject the ISO if prompted
3. Ensure the VM boots into the installed Linux system

If the VM boots back into the installer instead of Linux, the ISO is still attached or being prioritized during boot.

To fix this:

1. Shut down the VM
2. Open the VM settings in UTM
3. Remove or eject the ISO
4. Start the VM again

Your VM should now boot into Linux.

At this point, you have successfully created your headnode VM.

---

## Understanding Networking

Before expanding your setup into a cluster, it is important to understand the networking modes you will use.

A cluster is made up of multiple machines that need to communicate with each other. In a real cluster, machines are often separated into different networks depending on their purpose.

For this tutorial, you will use two main types of networks:

1. Shared Network
2. Internal / Host-Only Network

---

### Shared Network

The Shared Network is used to provide internet access to a VM.

It is similar to NAT networking in VirtualBox.

Use this for:

- Installing packages
- Downloading updates
- Accessing external repositories
- General internet access

In this tutorial, only the headnode will use the Shared Network.

---

### Internal / Host-Only Network

The Internal or Host-Only Network is used for private communication between VMs.

Use this for:

- Headnode to compute node communication
- Cluster traffic
- SSH between nodes
- MPI or benchmarking traffic in later tutorials

By default, this network does not provide internet access.

In this tutorial, the compute nodes will connect only to the private/internal network. They will not have direct internet access.

---

### Why Use Two Networks?

The headnode will have two network interfaces:

1. One interface for internet access
2. One interface for private cluster communication

The compute nodes will only have one network interface:

1. One interface for private cluster communication

This creates a simple cluster design where the headnode acts as the central machine.

---

## Expand the Headnode into a Cluster

Now that your headnode VM is working, you can expand the setup into a cluster.

You will do this by:

1. Adding a second network interface to the headnode
2. Creating compute nodes
3. Connecting the compute nodes to the same private/internal network
4. Assigning static IP addresses

---

## Suggested Cluster Layout

Your cluster will consist of:

- One headnode
- Two compute nodes

The headnode is the main node.

The compute nodes are worker machines that can later be used for distributed computing and benchmarking.

---

### Network Design

| Machine | Adapter 1 | Adapter 2 |
|---|---|---|
| Headnode | Shared Network | Internal / Host-Only Network |
| Compute Node 1 | Internal / Host-Only Network | - |
| Compute Node 2 | Internal / Host-Only Network | - |

---

### Visual Representation

```text
        INTERNET
            |
     [ Shared Network ]
            |
        Headnode
        Adapter 1: Shared Network
        Adapter 2: Internal Network
            |
     [ Internal / Host-Only Network ]
        |                         |
    Compute1                  Compute2
```
### Key Idea

The headnode has access to the internet.

The compute nodes do not have direct internet access.

All compute node communication happens through the private/internal network.

This mirrors how many real HPC clusters are structured, where compute nodes are often isolated and managed through a headnode or login node.

---

## Configure Networking in UTM

### Configure the Headnode

Your headnode already has one network interface using Shared Network.

Now add a second network interface for private cluster communication.

1. Shut down the headnode VM.
2. Open the VM settings in UTM.
3. Go to **Network**.
4. Add a new network interface.
5. Configure it as:

| Setting | Value |
|---|---|
| Network Mode | Emulated VLAN |
| VLAN Name | `cluster-net` |
| Emulated Network Card | `virtio-net-pci` |

Use a simple VLAN name like `cluster-net` and keep that exact name for all nodes.

### Private Network Interface

This second interface will be used only for communication with the compute nodes.

After starting the VM again, Linux should detect the new network interface.

Depending on the operating system, the interface names may look like:

The interface names do not have to match across all nodes.

What matters is that the correct interface is assigned to the correct network.

### Example Interface Mapping

| Machine   | Internet Interface | Private Interface |
|-----------|------------------|------------------|
| Headnode  | enp0s1           | enp0s2           |
| Compute1  | —                | enp0s1           |
| Compute2  | —                | enp0s1           |

This is normal.

### Create Compute Node VMs

Now create two additional VMs: `compute1` and `compute2`.

You can either:

- Install each compute node from ISO (same process as headnode), or
- Clone the headnode VM after installation and rename clones.

## Important Note About Cloning

If you clone a VM, the clone may keep some settings from the original VM.

After cloning, check the following:

- VM name  
- Linux hostname  
- Network interface settings  
- IP address  
- MAC address  

If two VMs have the same IP address, they will conflict on the network.

Each VM must have a unique IP address.

For each compute node:

1. Create or clone VM.
2. Set VM name (`compute1`, `compute2`).
3. In **Network**, configure only one adapter:
   - **Network Mode:** Emulated VLAN
   - **VLAN Name:** `cluster-net`
   - **Network Card:** `virtio-net-pci`
4. Do **not** add Shared Network to compute nodes.

All nodes must use the same VLAN name to be on the same private network.

---

## Configure IP Addresses

Now configure static IPs so the nodes can always find each other reliably.

Suggested addressing:

| Node | Interface | IP Address | CIDR |
|---|---|---|---|
| `headnode` | private adapter | `10.10.10.10` | `/24` |
| `compute1` | only adapter | `10.10.10.11` | `/24` |
| `compute2` | only adapter | `10.10.10.12` | `/24` |

Gateway/DNS are optional on private-only interfaces.  
For compute nodes without internet adapters, they are usually not needed.


