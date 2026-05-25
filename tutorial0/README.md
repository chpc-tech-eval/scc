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

Use **Virtualize** on Apple Silicon Macs because it provides better performance than emulation when using an ARM64/AArch64 operating system.

4. Select **Linux**

<img width="1068" height="780" alt="Screenshot 2026-05-25 at 15 03 00" src="https://github.com/user-attachments/assets/24534c63-c3e7-4640-bc49-bb8e4db7537f" />


---

### Step 2: Select ISO Image

Browse and select the Linux ISO file you downloaded earlier.

<img width="446" height="517" alt="Screenshot 2026-05-25 at 15 05 10" src="https://github.com/user-attachments/assets/54320504-9ad9-4d9e-bc75-5f42b8c3d6b9" />



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

> [!TIP]
> Your VM shares resources with your Mac.
>
> Do not allocate all available CPU cores or memory to the VM, as your Mac still needs resources to run macOS and UTM.
>
> **Example:**
> - If your Mac has **8 GB of RAM**, do not assign all 8 GB to the VM.
---

### Step 4: Configure the Initial Network

For the first VM setup, use:

| Setting               | Value             |
|----------------------|------------------|
| Network Mode         | Shared Network   |
| Emulated Network Card| virtio-net-pci   |

The **Shared Network** gives your VM internet access. This is useful for downloading packages and updates.

The **virtio-net-pci** network card is recommended because it is efficient and commonly used in virtualized Linux environments.

<img width="782" height="393" alt="Headnode shared network" src="https://github.com/user-attachments/assets/8748b108-cbc2-47e7-89c7-a6bf0bc5dd0f" />


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

<img width="791" height="633" alt="Screenshot 2026-05-25 at 15 18 43" src="https://github.com/user-attachments/assets/fb0beb71-5a71-4eeb-9016-8aa2c93f3030" />


3. Follow the installation steps
4. Select your language and keyboard settings

<img width="1279" height="834" alt="Screenshot 2026-05-25 at 15 16 47" src="https://github.com/user-attachments/assets/c27ff459-35b3-497e-9c41-c2390e599882" />


5. Create a username and password

<img width="1278" height="833" alt="Screenshot 2026-05-25 at 15 16 57" src="https://github.com/user-attachments/assets/38fd0e2d-5fc2-4961-b59a-f6f39b9d85f0" />


6. Complete the installation

If the installer requires a root password or an administrator user, make sure you set one.

---

### Step 7: Reboot and Eject the ISO

After installation:

1. Reboot the VM
2. Remove or eject the ISO if prompted
3. Ensure the VM boots into the installed Linux system

> [!WARNING]
> If your VM boots back into the installer instead of Linux, the ISO is still attached or being prioritised during boot.
>
> **To fix this:**
> - Shut down the VM  
> - Open the VM settings in UTM  
> - Remove or eject the ISO  
> - Start the VM again  
>
> Your VM should now boot into Linux.

At this point, you have successfully created your headnode VM.

## Verify Your Headnode

Before continuing, it is important to confirm that your VM is working correctly and that you can interact with it.

---

### Connect to Your VM

If you are using the UTM console, you should already see your Linux terminal.

View your network Interfaces and IP address:

```text
ip a
```

<img width="917" height="493" alt="Screenshot 2026-05-25 at 12 02 53" src="https://github.com/user-attachments/assets/7708dff9-4057-40ff-83e1-6b7c18371666" />


If SSH is enabled, you can also connect remotely using:

```bash

ssh <username>@<ip-address>
```

<img width="580" height="73" alt="Screenshot 2026-05-25 at 15 45 40" src="https://github.com/user-attachments/assets/82e92600-c2e9-4638-83b9-b39d495cefc7" />

You can test connectivity by also pinging an external host:

```text
ping -c 4 google.com
```

---

## Understanding Networking

Before expanding your setup into a cluster, it is important to understand the networking modes you will use.

A cluster is made up of multiple machines that need to communicate with each other. In a real cluster, machines are often separated into different networks depending on their purpose.

For this tutorial, you will use two main types of networks:

1. Shared Network
2. Internal / Host-Only Network

There is also an additional type:

3. Bridged Network

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

## 3. Bridged Network

Bridged mode places the VM directly onto your physical network.

- VM receives an IP from your router
- VM behaves like a real machine on your network
- Other devices can directly access the VM

Be careful when using bridged mode.

For example:
- Misconfigured services like DHCP servers can affect your home or office network

---

### Why Use The Two Networks?

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

The headnode has access to the internet. The compute nodes do not have direct internet access. All compute node communication happens through the private/internal network. This mirrors how many real HPC clusters are structured, where compute nodes are often isolated and managed through a headnode or login node.

---

## Configure Networking in UTM

### Configure the Headnode

Your headnode already has one network interface using Shared Network.

Now add a second network interface for private cluster communication.

1. Shut down the headnode VM.
2. Open the VM settings in UTM.
3. Go to **Network**.

<img width="806" height="452" alt="Screenshot 2026-05-25 at 15 30 44" src="https://github.com/user-attachments/assets/81b81470-c062-498a-a183-4fc6f51cf8ee" />


4. Add a new network interface.

<img width="801" height="403" alt="Screenshot 2026-05-25 at 15 31 08" src="https://github.com/user-attachments/assets/17820af4-b568-4e38-a4b3-c591e8c6af2e" />


5. Configure it as:

| Setting | Value |
|---|---|
| Network Mode | Emulated VLAN |
| VLAN Name | `cluster-net` |
| Emulated Network Card | `virtio-net-pci` |

Use a simple VLAN name like `cluster-net` and keep that exact name for all nodes.

### Private Network Interface

This second interface will be used only for communication with the compute nodes. After starting the VM again, Linux should detect the new network interface. Depending on the operating system, the interface names may look like:

```text
enp0s1
enp0s2
eth0
eth1
ens3
ens4
```

The interface names do not have to match across all nodes. What matters is that the correct interface is assigned to the correct network.

> [!WARNING]
> The newly added network interface will not work immediately.
>
> By default, it has no IP address and is not active. You must manually configure and activate it before it can be used for communication.

<img width="650" height="319" alt="Screenshot 2026-05-25 at 12 08 21" src="https://github.com/user-attachments/assets/785b56fa-c703-4988-b3d8-5420bcc6531c" />



To configure the new interface, use the NetworkManager text user interface:


```text
sudo nmtui
```

<img width="1275" height="835" alt="Screenshot 2026-05-25 at 16 02 49" src="https://github.com/user-attachments/assets/2f2655aa-98a1-4cf4-8a3d-118fb3d17988" />

If enp0s2 is not showing, add it manually, then edit the settings.

<img width="661" height="514" alt="Screenshot 2026-05-25 at 16 03 05" src="https://github.com/user-attachments/assets/752afb44-d3d7-4aca-a021-528d0e4bbcac" />

Set IPv4 Configuration to Manual, the set a private IP address e.g 192.168.100.1/24 . Leave evrything else as is. Save the settings and then activate the connection. 


<img width="649" height="521" alt="Screenshot 2026-05-25 at 16 03 22" src="https://github.com/user-attachments/assets/ff0abef0-f503-4897-97d0-f121bec6d482" />


You should then see: 

<img width="648" height="661" alt="Screenshot 2026-05-25 at 12 12 39" src="https://github.com/user-attachments/assets/93062ff0-3a1c-422d-8a7a-20eac2b641ff" />



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

### Configure Compute Node Network Interfaces

> [!IMPORTANT]
> Just like the headnode, the network interface on each compute node will **not be automatically configured or activated**.
>
> You must manually assign an IP address and bring the interface up before it can be used.

---

Each compute node must be configured on the same private network as the headnode.

For example:

| Machine   | IP Address       |
|-----------|------------------|
| Headnode  | 192.168.100.1    |
| Compute1  | 192.168.100.2    |
| Compute2  | 192.168.100.3    |

---

### Configure Using `nmtui`

Run the following command on each compute node:

```bash
sudo nmtui
```


Steps

1. Select Edit a connection
2. Choose the network interface (e.g. enp0s1)
3. Set the following:

```text
Compute1

* IPv4 Configuration → Manual
* Address → 192.168.100.2/24
* Gateway → 192.168.100.1
* DNS → 8.8.8.8

⸻

Compute2

* IPv4 Configuration → Manual
* Address → 192.168.100.3/24
* Gateway → 192.168.100.1
* DNS → 8.8.8.8

```

⸻

4. Save the configuration
5. Go back and select Activate a connection
6. Select the interface to bring it UP


---

## Test Cluster Connectivity

Now that all nodes are configured, you can test communication across the cluster.

---

### Test Private Network Connectivity

From the **headnode**, try pinging the compute nodes:

```bash
ping 192.168.100.2
ping 192.168.100.3
```

From one compute node, try pinging the headnode and the other compute node:


```bash
ping 192.168.100.1
ping 192.168.100.2/3
```

Quick Check

Try the following command from one of the compute nodes:

```bash
ping -c 4 8.8.8.8
```

## Question

Can the compute node reach the internet?

## Answer

No — the compute nodes do not have direct internet access.

This is because:

* They are only connected to the internal/private network
* They do not have a connection to the Shared Network
* There is no route to external networks

---
##Enabling Internet Access via the Headnode (NAT Forwarding)

To allow compute nodes to access the internet, the headnode can act as a **gateway** using Network Address Translation (NAT).

This allows traffic from compute nodes to pass through the headnode to the internet.

---

### Step 1: Enable IP Forwarding on the Headnode

Run the following command on the headnode:

```bash
sudo sysctl -w net.ipv4.ip_forward=1
```

To make this change permanent:


```bash
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
```
### Step 2: Configure NAT Using iptables

Run the following on the headnode:

```bash
sudo iptables -t nat -A POSTROUTING -o enp0s1 -j MASQUERADE
```
### Step 3: Allow Forwarding Traffic

```bash
sudo iptables -A FORWARD -i enp0s2 -o enp0s1 -j ACCEPT
sudo iptables -A FORWARD -i enp0s1 -o enp0s2 -m state --state RELATED,ESTABLISHED -j ACCEPT
```
---
> [!IMPORTANT]
> Replace the interface names if needed:
>
> - `enp0s1` → Shared Network (internet-facing interface)
> - `enp0s2` → Internal / Host-only Network (cluster interface)

---
### Step 4: Test Connectivity Again

From a compute node, run:

```bash
ping -c 4 8.8.8.8
```
If successful, the compute node can now reach the internet through the headnode.

⸻

What Just Happened?

* The headnode is now acting as a router
* Compute nodes send traffic to the headnode
* The headnode forwards traffic to the internet
* Responses are routed back through the headnode

This is a simplified version of how networking works in real clusters and cloud environments.
