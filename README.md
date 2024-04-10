# CHPC Student Cluster Competition Tutorials

This repository contains the ground truth of information that needs to be covered by the tutorials of the Student Cluster Competition. 

## How To Use
### Adding Content

#### When editing existing content


1. `git clone` a local copy of the repository, to your personal work space.
1. Create a new branch to work on. i.e. `git branch tutX_rework` followed by `git checkout tutX_rework`, or simply use a single command `git checkout -b tutX_rework`.
   - Give the branch a sensible name.
   - You are encouraged to push the branch back upstream so that collaborators can see what you are working on as you make the changes.
1. Make the appropriate changes.
1. `git add <relative_path_to_changed_file(s)>`
1. `git commit -m "some_message_pertaining_to_changes_made"`
1. `git push`
1. Create a merge request to the upstream Tutorial project.

## Table of Contents

- [Tutorial 1](#tutorial-1)
- [Tutorial 2](#tutorial-2)
- [Tutorial 3](#tutorial-3)
- [Tutorial 4](#tutorial-4)
- [Tutorial 5](#tutorial-5)

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
