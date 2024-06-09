#  Student Cluster Competition - Tutorial 2
    
## Table of Contents

1. [Overview](#overview)
1. [Spinning Up a Compute Node in OpenStack]()
   1. [Compute Node Considerations]()
1. [Accessing Your Compute Node]()
   1. [IP Addresses and Routing]()
   1. [Command Line Proxy Jump Directive]()
   1. [Permanent `~/.ssh/config` Configuration]()
   1. [Verifying Networking Setup through Network Manager]()
      1. [Head Node (`nmtui`)]()
      1. [Compute Node (`nmcli`)]()
1. [Local User Account Management](#local-user-account-management)
   1. [Create Team User Account](#create-centos-user-account)
      1. [Head Node](#head-node)
      1. [Compute Node](#compute-node)
      1. [Super User Access](#super-user-access)
1. [Configuring a Basic Stateful Firewall _(Optional_)]()
1. [Network Time Protocol]()
   1. [NTP Server (Head Node)]()
   1. [NTP Client (Compute Node)]()
1. [Network File System](#network-file-system)
   1. [NFS Server (Head Node)](#nfs-server-head-node)
   1. [NFS Client (Compute Node)](#nfs-client-compute-node)
      1. [Mounting An NFS Mount](#mounting-an-nfs-mount)
      1. [Making The NFS Mount Permanent](#making-the-nfs-mount-permanent)
1. [Passwordless SSH](#passwordless-ssh)
1. [Central User Management](#central-user-management)
   1. [Out-Of-Sync Users and Groups](#out-of-sync-users-and-groups)
      1. [Head Node](#head-node-1)
      1. [Compute Node](#compute-node-1)
      1. [Clean Up](#clean-up)
1. [Ansible User Declaration]()
1. [WireGuard VPN Cluster Access]()

## Overview

This tutorial will demonstrate how to access web services that are on your virtual cluster via the web browser on your local computer. It will also cover basic authentication and central authentication.

<u>In this tutorial you will:</u>

- [ ] Install a web server.
- [ ] Create an SSH tunnel to access your web service.
- [ ] Create new local user accounts.
- [ ] Add local system users to sudoers file for root access.
- [ ] Share directories between computers.
- [ ] Connect to machines without a password using public key based authentication.
- [ ] Install and use central authentication.

<div style="page-break-after: always;"></div>

## Spinning Up a Compute Node in OpenStack
### Compute Node Considerations
## Accessing Your Compute Node
### IP Addresses and Routing
### Command Line Proxy Jump Directive
### Permanent `~/.ssh/config` Configuration
### Verifying Networking Setup through Network Manager

You have been assigned IP addresses for your VMs. To identify these, go to the OpenStack user interface and navigate to `Compute -> Instances`. In the list of virtual machines presented to you, click the name of the virtual machine instance to see an overview of your virtual machine specifications, under `IP Addresses` you will see two IP addresses (IPs) assigned to that particular VM together with their respective networks  

For example, two IP addresses listed in the OpenStack IP addresses, will look like `10.100.50.x` and `154.114.57.x` where `x` is your specific vm address number. `10.100.50.x` network is for internal use and `154.114.57.x` is for public facing usage. 

You can check your network interfaces by using the `ip a` command. 

**Rocky 9.3** uses `Network Manager` (**NM**) to manage network settings. `Network Manager` is a service created to simplify the management and addressing of networks and network interfaces on Linux machines.
You can read the ff links for more information or better understanding: 
https://docs.rockylinux.org/gemstones/network/RL9_network_manager/ 
https://docs.rockylinux.org/guides/network/basic_network_configuration/ 




##### Head Node (`nmtui`)

For the head node, create a new network definition using the nmtui graphical tool using the following steps:

First we must make sure that our network interfaces are managed by Network Manager. By default, this should already be the case. Use the following command to check if the network interfaces are managed:


`~$ nmcli dev`


You should see something other than "unmanaged" next to each of the interfaces (excluding lo). If any of your network interfaces (other than lo) say "unmanaged", do the following:


`~$ nmcli dev set <interface> managed yes`


The nmtui tool is a console-graphical tool used to set up and manage network connections for Network Manager.


`~$ nmtui`


You'll be presented with a screen, select Edit a connection, followed by <Add> and then Ethernet.

For Profile Name, type the name of the interface you want to assign an IP address to, like eth0 or eth1, and type the same thing for Device (in this instance, Device means interface).
For IPv4 CONFIGURATION, change <Automatic> to <Manual>. This tells NM that we want to assign a static IP address to the connection. Hit enter on <Show> to the right of IPv4 CONFIGURATION and enter the following information:

Addresses: Hit <Add> and enter the IP address (found in OpenStack) for this interface. After the IP address, add the text "/24" to the end. It should read as <ip_address>/24 with no spaces. The "/24" is the subnet mask of the IP address in CIDR notation.

***Gateway: Enter the gateway address here. This will be the Sebowa gateway for the external network of the head node.

DNS servers: Hit <Add> and enter 8.8.8.8. This is the public DNS server of Google and is used to look up website names. (NB: DNS is explained later!)
Hit <OK> at the bottom of the screen.

Repeat the above processes for any other network interface you want to give an IP address to, if there are more on your machine (you can use ip a to check how many there are).

The networks should now be active. You can confirm this by going <Back> and then to Activate a connection. If you see stars to the left of each of the networks that you have created, then the networks are active. If not, hit enter on the selected network to active it.

Your head node should now have the correct IP addresses. Exit nmtui and check the networking setup is correct. To do so, use the following commands:


`~$ ip a`

`~$ ip route`


`ip a` will show you the interfaces and their assigned IP addresses.
ip route will list the interfaces and their assigned routes.


Compute Node (nmcli)

You must also set the static IP addressing for all other nodes in your cluster. In order to explore different options for doing so, please use the nmcli command. This is the command-line interface (CLI) for Network Manager, which is an alternative to the above nmtui, which is simply a graphical wrapper for the CLI.

Please look at the following website in order to get the commands that you will need to create a static IP address network connection using the CLI:

https://www.golinuxcloud.com/set-static-ip-rocky-linux-examples/ 

  Note that the IP addresses used in this web guide will not be the same as the ones that you need to use for your node(s) and some of the commands may not be relevant to you.

At this point you should test connectivity between your nodes. Using the ping command, you can see whether the nodes can speak to each other via the network. From your head node, try to ping your compute node:

`~$ ping <compute_node_ip>`

If you get a timeout, then things are not working. Try to check your network configurations again.


_**Please read [what-is-ip-routing](https://study-ccna.com/what-is-ip-routing/) to gain a better understanding of IP routing.**_ This will be impoortant for the rest of this competition and can help your understanding when debugging issues.

<div style="page-break-after: always;"></div>


## Local User Account Management

In enterprise systems and HPC, it's common to manage user accounts from one central location. These network accounts are then synchronised to the machines in your fleet via the network. This is done for safely, security and management purposes.

When creating a user account locally on a Linux operating system, it's provided with a user ID (uid) and a group ID (gid). These are used to tell the operating system which user this is and which groups of permissions they belong to. When you create a user with the default settings of the built-in user creation tools, it will generally increment on from the last UID used. This can be different for different systems. If UID/GID numbers do not match up across the nodes in your cluster, there can be all sorts of headaches for some of the tools and services that we will set up later in this competition.

We're going to demonstrate some of this.

Right now you have one user: `root`. `root` is the default super-user of Linux operating systems. It is all powerful. It is generally **NOT recommended** to operate as `root` for the majority of things you would do on a system. This is to prevent things from going wrong.

When logged in to the head node or compute node, check the UID and GID of `root` by using the `id` command. 

```bash
~$ id
```

You should see something like the following:

```bash
uid=0(root) gid=0(root) groups=0(root) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
```

This shows that `root` is the user `0` and it's primary group (GID) is group `0`. It also states that it only belongs to one group, which is the `root` group (`0`).

### Create Team User Account

#### Head Node

Let us now create a user account on the head node:

1. Log into the head node

2. Use the `adduser` command to create a new user called `tim` and then give it a password.

    ```bash
    [root@headnode ~]$ adduser -U -m tim
    [root@headnode ~]$ passwd tim
    ```

    `-U` tells `adduser` to create a group for the user and `-m` means to create the user home directory.

3. Check the ID of the new user

    ```bash
    [root@headnode ~]$ id tim
    ```

    You'll see something like the following:

    ```bash
    uid=1000(tim) gid=1000(tim) groups=1000(tim)
    ```

    As you can tell, it has a different ID for the user and group than `root`.

#### Compute Node

Log into thetest compute node and try to verify that the `tim` user **does NOT exist** there:

```bash
[root@computenode ~]$ id tim
```

You'll be prompted with an error:

```bash
id: ‘tim’: no such user
```

We will now create the same user here. Follow the steps above for creating the `tim` user on the compute node.

#### Super User Access

The `tim` user will not have the privileges to do anything that modify system files or configurations. Many Linux operating systems come with a program called `sudo` which manages and allows normal user accounts to access `root` privileges.

A user is only able to evoke root privileges if their account has been explicitly added to at least one of the following:
- the default sudo users group (the actual term of this group varies across Linux variants, such as **wheel** **sudoers** etc.)
- a newly created sudo users group, 
- or, if the user has been explicitly added as a privileged user directly in the Sudo configuration file.


The `sudo` program is controlled by a file located at `/etc/sudoers`. This file specifies which users and/or groups can access superuser privileges. In this file for a default **Rocky 9** installation, it specifies that the user `root` is allowed to run all actions and any user in the `wheel` group is also allowed to:

```ini
## Allow root to run any commands anywhere 
root	ALL=(ALL) 	ALL

## Allows members of the 'sys' group to run networking, software, 
## service management apps and more.
# %sys ALL = NETWORKING, SOFTWARE, SERVICES, STORAGE, DELEGATING, PROCESSES, LOCATE, DRIVERS

## Allows people in group wheel to run all commands without a password
%wheel ALL=(ALL) NOPASSWD: ALL
```

To avoid modifying `/etc/sudoers` directly, we can just add `tim` to the `wheel` group.

**On each of your nodes**, add the `tim` user to the `wheel` group:

```bash
[root@node ~]$ usermod -aG wheel tim
```

Now log out and then log back into your node as `tim`. You can use `sudo` one of two ways:

1. To become the `root` user:

    ```bash
    [rocky@headnode ~]$ sudo su
    ```

2. To run a command with superuser privileges:

    ```bash
    [rocky@headnode ~]$ sudo <command>
    ```


> **! >>> From now on, you should use the `tim` user for all the configuration you can and should avoid logging in as the `root` user.**

<div style="page-break-after: always;"></div>


> **! >>> Without access to a working DNS server you won't be able to install packages on your compute node (or head node for that matter), even if the internet is otherwise working.**

<div style="page-break-after: always;"></div>


## Network Time Protocol

**NTP** or **network time protocol** enables you to synchronise the time across all the computers in your network. This is important for HPC clusters as some applications require that system time be accurate between different nodes (imagine receiving a message 'before' it was sent).

It is also important that your timezones are also consistent across your machines. Time actions on **Rocky 9** can be controlled by a tool called `timedatectl`. For example, if you wanted to change the timezone that your system is in, you could use `timedatectl list-timezones`, find the one you want and then set it by using `timedatectl set-timezone <timezone>`. `timedatectl` can also set the current time on a local machine and more. 

You will now **setup the NTP service** (through the `chronyd` implementation) on your head node and then connect your compute nodes to it.
You can read the ff link for more information: https://reintech.io/blog/configuring-time-synchronization-ntp-rocky-linux-9#google_vignette  


### NTP Server (Head Node)

1. Install the Chrony software package using the Rocky package manager, `dnf`:

    ```bash
    [root@headnode ~]$ dnf install chrony
    ```

2. Edit the file `/etc/chrony.conf` and modify the `allow` declaration to include the internal subnet of your cluster (uncomment or remove the "#" in front of `allow` if it's there, otherwise this is ignored).

    ```conf
    allow 10.100.50.0/24
    ```

3. Chrony runs as a service (daemon) and included with Rocky 9 by default. 
Restart the chrony daemon with `systemctl`. This will also start it if it was not yet running:

    ```bash
    [root@headnode ~]$ systemctl restart chronyd
    ```

    Ensure that the chrony service is set to start automatically on your next boot/rebbot:

    ```bash
    [root@headnode ~]$ systemctl enable chronyd
    ```

4. Add chrony to the firewall exclusion list:

    ```bash
    [root@headnode ~]$ firewall-cmd --zone=internal --permanent --add-service=ntp
    [root@headnode ~]$ firewall-cmd --reload
    ```

You can view the clients that are connected to the chrony server on the head node by using the following command on the head node:

```bash
[root@headnode ~]$ chronyc clients
```

Confirm the NTP synchronization status.

```bash
[root@headnode ~]$ chronyc tracking
```


This will show empty until you do the steps below.

### NTP Client (Compute Node)

1. Install the Chrony software package the same way as the head node.

2. Edit the file `/etc/chrony.conf`, comment out (add a "#" in front of) all the `pool` and `server` declarations and add this new line to the file:

    ```conf
    server <head_node_ip>
    ```

3. Restart the chronyd service as above.

4. Enable the chronyd service as above.

Check `chronyc clients` on the head node to see if the compute node is connected and getting information from the head node.

<span id="fig5" class="img_container center" style="font-size:8px;margin-bottom:20px; display: block;">
    <img alt="test" src="./resources/chrony_clients.png" style="display:block; margin-left: auto; margin-right: auto;" title="caption" />
    <span class="img_caption" style="display: block; text-align: center;margin-top:5px;margin-top:5px;"><i>Figure 5: The compute node (chrony client) is a client of the head node (chrony server).</i></span>
</span>


## Network File System

Network File System (NFS) enables you to easily share files and directories over the network. NFS is a distributed file system protocol that we will use to share files between our nodes across our private network. It has a server-client architecture that treats one machine as a server of directories, and multiple machines (clients) can connect to it.

This tutorial will show you how to export a directory on the head node and mount it through the network on the compute nodes. With the shared file system in place it becomes easy to enable **public key based ssh authentication**, which allows you to ssh into all the computers in your cluster without requiring a password.

### NFS Server (Head Node)

The head node will act as the NFS server and will export the `/home/` directory to the compute node. The `/home/` directory contains the home directories of all the the non-`root` user accounts on most default Linux operating system configurations. For more information read the this link https://docs.rockylinux.org/guides/file_sharing/nfsserver/  


1. NFS requires two services to function:
        The network service (of course)
        The rpcbind service

2. Install the NFS service on the head node:

    ```bash
    [rocky@headnode ~]$ sudo dnf install nfs-utils
    ```

3. Check the status of the rpcbind services:


    ```bash
    [rocky@headnode ~]$ sudo systemctl status rpcbind
    ```
  

 4. Verify the version of NFS installation.


    ```bash
    [rocky@headnode ~]$ sudo cat /proc/fs/nfsd/versions
                        -2 +3 +4 +4.1 +4.2
    ```
     NFS versions 3 and 4 are enabled by default, and version 2 is disabled. NFSv2 is pretty old and outdated, and hence you can see the -ve sign in front of it.
 
 

3. NFS shares (directories on the NFS server) are configured in the `/etc/exports` file. Here you specify the directory you want to share, followed by the IP address or range you want to share to and then the options for sharing. We want to export the `/home` directory, so edit `/etc/exports` and add the following:

    ```conf
    /home    10.100.50.0/24(rw,async,no_suntree_check,no_root_squash)
    ```

    Let us go through all the options for NFS exports.
        rw - gives the client machine read and write access on the NFS volume.

        sync - this option forces NFS to write changes to the disk before replying. This option is considered more reliable. However, it also reduces the speed of file operations.

        no_subtree_check - this option prevents subtree checking, a process where the host must check whether the file is available along with permissions for every request. It can also cause issues when a file is renamed on the host while still open on the client. Disabling it improves the reliability of NFS.

        no_root_squash - By default, NFS translates requests from a root user on the client into a non-privileged user on the host. This option disables that behavior and should be used carefully to allow the client to gain access to the host.

4. Start and enable the `nfs-server` service using `systemctl`.

       ```bash
    [rocky@headnode ~]$ sudo systemctl enable --now nfs-server rpcbind
    ```

5. NFS on Rocky Linux makes use of three different services, and they all need to be allowed through your firewall. You can add these rules with firewall-cmd:

    ```bash
    [rocky@headnode ~]$ sudo firewall-cmd --add-service={nfs,mountd,rpc-bind} --permanent
    [rocky@headnode ~]$ sudo firewall-cmd --reload
    ```

### NFS Client (Compute Node)

The compute node acts as the client for the NFS, which will mount the directory that was exported from the server (`/home`). Once mounted, the compute node will be able to interact with and modify files that exist on the head node and it will be synchronised between the two.

#### Mounting An NFS Mount

The `nfs-utils, nfs4-acl-tools` packages need to be installed before you can do anything NFS related on the compute node. 

`sudo dnf install nfs-utils nfs4-acl-tools`

Since the directory we want to mount is the `/home` directory, the user can not be in that directory.

1. Mount the /home directory from the head node using the `mount` command:

    ```bash
    [rocky@computenode ~]$ sudo mount -t nfs <headnode_ip_or_hostname>:/home /home
    ```

2. Once done, you can verify that the `/home` directory of the head node is mounted by using `df -h`:

    ```bash
    [rocky@computenode ~]$ df -h
    ```

<span id="fig1" class="img_container center" style="font-size:8px;margin-bottom:0px; display: block;">
    <img alt="webserver" src="./resources/home_dir_mounted.png" style="display:block; margin-left: auto; margin-right: auto; width: 50%;" title="caption" />
    <span class="img_caption" style="display: block; text-align: center; margin-left: auto;
    margin-right: auto; width: 45%;"><i>Figure 2: The output of the `df -h` command shows that the `/home` directory of the head node is mounted on the `/home` directory of the compute node.</i></span>
</span>

With this mounted, it effectively replaces the `/home` directory of the compute node with the head node's one until it is unmounted. To verify this, create a file on the compute node's `rocky` user home directory (`/home/rocky`) and see if it is also automatically on the head node. If not, you may have done something wrong and may need to redo the above steps!

#### Making The NFS Mount Permanent

Using `mount` from the command line will not make the mount permanent. It will not survive a reboot. To make it permanent, we need to edit the `/etc/fstab` file on the compute node. This file contains the mappings for each mount of any drives or network locations on boot of the operating system.

1. First we need to unmount the mount we made:

    ```bash
    [rocky@computenode ~]$ sudo umount /home
    ```

2. Now we need to edit the `/etc/fstab` file and add this new line to it (be careful not to modify the existing lines!):

    ```text
    headnode.cluster.scc:/home    /home     nfs auto,nofail,noatime,nolock,tcp,actimeo=1800,_netdev,intr    0 0
    ```

    The structure is: `<host>:<filesystem_dir> <local_location> <filesystem_type> <filesystem_options> 0 0`. The last two digits are not important for this competition and can be left at 0 0.

    For the nfs options listed above:

    - `_netdev` tells the operating system to only mount the device once network has been established (it's a network device).
    - `intr` allows NFS operations to be interrupted in the case that the server is unreachable.

3. With this done, we can mount the new `/etc/fstab` entry:

    ```bash
    [rocky@computenode ~]$ sudo mount -a 
    ```

4. Once again, you can verify that the `/home` directory of the head node is mounted by using `df -h`:

    ```bash
    [rocky@computenode ~]$ df -h
    ```

<div style="page-break-after: always;"></div>

## Passwordless SSH

When managing a large fleet of machines or even when just logging into a single machine repeatedly, it can become very time consuming to have to enter your password repeatedly. Another issue with passwords is that some services may rely on directly connecting to another computer and can't pass a password during login. To get around this, we can use [public key based authentication](https://www.ssh.com/academy/ssh/public-key-authentication) to replace passwords.

1. Generate an SSH key-pair for your user. This will create a public and private key for your user in `/home/<username>/.ssh`. The private key is your identity and the public key is what you share with other computers.

      ```bash
    [rocky@headnode ~]$ ssh-keygen
      ```
    You can hit enter with the defaults/empty for all the prompts.
    Ensure that user password is set on both headnode and computes nodes 

      ```bash
    [rocky@headnode ~]$ sudo passwd rocky 
      ```

    Use ssh-copy-id to copy the public key generated from one machine to another 

      ```bash
    [rocky@headnode ~]$ ssh-copy-id rocky@computenode 
      ```
     
     enter password when promted  
     
     OR


2. Since your `/home` directory is shared with your compute node, copying the public key generated by `ssh-keygen` into the `authorized_keys` file in the same `/home` directory will appear the same on the compute node.

    ```bash
    [rocky@headnode ~]$ cd ~/.ssh
    [rocky@headnode .ssh]$ cat id_rsa.pub > authorized_keys
    ```

  
3. SELinux, the security engine that **Rocky 9** uses, may complain about permissions for this directory if you try to use public key authentication now. To fix this, run the following commands:

    ```bash
    [rocky@headnode ~]$ chmod 700 ~/.ssh/
    [rocky@headnode ~]$ chmod 600 ~/.ssh/authorized_keys
    [rocky@headnode ~]$ sudo restorecon -R -v ~/.ssh
    ```

4. SSH to the **compute node** and run the following command:

    ```bash
    [centos@computenode ~]$ sudo setsebool -P use_nfs_home_dirs 1
    ```

5. Exit **back to the head node**

6. SSH to your compute node without a password and land on the shared filesystem. If you are prompted with a password it means that something is not set up correctly.

> **! >>> `chmod` and `chown` are Linux permission and ownership modification commands. To learn more about these commands and how they work, please go to the following link: [https://www.unixtutorial.org/difference-between-chmod-and-chown/](https://www.unixtutorial.org/difference-between-chmod-and-chown/).**

How this works is that you copy the public key to the computer that you want to connect to without a password's `authorized_keys` file. When you SSH to the machine that you copied your public key to, the `ssh` tool will send a challenge that can only be decrypted if the target machine has the public key and the local machine has the private key. If this succeeds, then you are who you say you are to the target computer and you do not require a password. [Please read this for more detailed information](https://www.ssh.com/academy/ssh/public-key-authentication).

<div style="page-break-after: always;"></div>

## Central User Management

### Out-Of-Sync Users and Groups

When managing a large cluster of machines, it gets really complicated to manage user ID and group ID mappings. With things like shared file systems (e.g. NFS), if user account names are the same, but IDs don't match across machines then we get permission problems. 

If users are created out-of-sync across the cluster then this becomes a problem very quickly. Let us take Alice and Bob for example:

1. Alice and Bob are both system administrators working on a cluster.
2. There is no central authentication and user/group accounts are made manually.
3. Alice creates a user `alice` on the head node using the `adduser` command listed in this tutorial.
4. While Alice does this, Bob creates user `bob` on the compute node in the same way.
5. Alice then creates user `alice` on the compute node.
6. Bob creates `bob` on the head node.

Even though the names are the same:

- `alice` on the **head node** has a UID/GID of `1000`/`1000`
- `bob` on the **head node** has a UID/GID of `1001`/`1001`
- `alice` on the **compute node** has a UID/GID of `1001`/`1001`.
- `bob` on the **compute node** has a UID/GID of `1000`/`1000`.

These do not match, so if Alice wants to create a file on the head node and access that file on the compute node she will get permission errors as `1000` is not the same as `1001`.

User- and group- names do not matter to Linux, only the numerical IDs. Let us demonstrate this now.

#### Head Node

1. Create a new user on the head node, let's call it `outofsync`. If you check it's IDs with `id outofsync`, you should see it belongs to UID/GID `1001`. 

2. Set the password for this user and log in as this user.

3. Create a file in the home directory of `outofsync` (`/home/outofsync`) called `testfile.txt` and put some words in it.

#### Compute Node

1. Create a new user on the compute node called `unwittinguser`. If you check the ID of this user, you will see that `unwittinguser` has UID/GID of `1001`.

2. Create a new user on the compute node called `outofsync`. If you check the ID of this user, you will see that `outofsync` has UID/GID of `1002`.

3. Set the password for the `outofsync` user.

4. Log into the compute node as `outofsync`.

5. You will see that the terminal complains about permission errors and that you aren't logged into the user's home directory.

6. You will not be able to read the `testfile.txt` file in `/home/outofsync/testfile.txt` if you tried.

This happens because you have an NFS mount for `/home`, replacing (while mounted) the compute node's `/home` with the head node's `/home` and the UID/GID for `outofsync` on the compute node does not match the one on the head node.

Check `ls -ln /home/outofsync` on the **head node** and you'll see that the `testfile.txt` belongs to `1001`, not `1002`.

<span id="fig3" class="img_container center" style="font-size:8px;margin-bottom:0px; display: block;">
    <img alt="webserver" src="./resources/ls_uid_different.png" style="display:block; margin-left: auto; margin-right: auto; width: 50%;" title="caption" />
    <span class="img_caption" style="display: block; text-align: center; margin-left: auto;
    margin-right: auto; width: 45%;"><i>Figure 3: The head node's `testfile.txt` is owned by user 1001, which is user `outofsync` on the head node.</i></span>
</span>

#### Clean Up

**Before proceeding, you must delete the users that you have created on the machines.**

To delete a user you can use the command below:

```bash
~$ sudo userdel -r <username>
```

Do this command for:

- `outofsync` on the head node.
- `unwittinguser` on the compute node.
- `outofsync` on the compute node.

### Ansible User Declarationx

https://reintech.io/blog/installing-ansible-rocky-linux-9-configuration-management

https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-rocky-linux-9  

### adding users 

https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-automate-initial-server-setup-on-rocky-linux-9 

