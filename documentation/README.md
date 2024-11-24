# **Creating a Cluster on AWS with Limited Resources**

This guide walks you through creating a basic cluster on AWS using the **free tier package**, leveraging the following resources:

- **Instance Type**: t2.micro
- **Operating System**: RHEL 9
- **Specifications**:
  - 1 vCPU
  - 1 GiB Memory
  - 30 GiB EBS Storage

---

## **Step 1: Setting Up a Virtual Private Cloud (VPC)**

### **1.1 Access the VPC Dashboard**
1. In the AWS Management Console, search for **VPC** in the search bar.
2. Navigate to the **VPC Dashboard**. You'll notice a **default VPC**. Ignore it; we'll create a custom VPC.
3. Click the **Create VPC** button.

<p align="center"><img alt="VPC Dashboard" src="../documentation/resources/Screenshot%202024-11-18%20110534.png" width=900 /></p>

### **1.2 Configure the VPC**
1. Select **VPC and More**.
2. Set the **name** of your VPC and specify the **CIDR block** (e.g., `10.0.0.0/16`).
3. Turn on **Auto-Generate CIDR Blocks** for simplicity.
4. Leave the **IPv6** and **Tenancy** settings as default.

<p align="center"><img alt="VPC Configuration" src="../documentation/resources/Screenshot%202024-11-18%20112244.png" width=900 /></p>

5. Choose:
   - **1 Availability Zone**
   - **1 Public Subnet**
   - **1 Private Subnet**
6. Assign CIDR blocks to the public and private subnets. AWS will automatically configure NAT gateways and routing as needed.

<p align="center"><img alt="Subnets Configuration" src="../documentation/resources/Screenshot%202024-11-18%20112307.png" width=900 /></p>

---

## **Step 2: Launching a Headnode Instance**

### **2.1 Access the EC2 Dashboard**
1. In the AWS Management Console, search for **EC2**.
2. Navigate to the **EC2 Dashboard**.

<p align="center"><img alt="EC2 Dashboard" src="../documentation/resources/Screenshot%202024-11-18%20112244.png" width=900 /></p>

### **2.2 Create the Instance**
1. Click **Launch Instance** and provide the following details:
   - **Name**: Headnode
   - **AMI**: Red Hat Enterprise Linux (RHEL) 9
   - **Instance Type**: t2.micro
2. Configure **Key Pair**:
   - Use an existing key pair or create a new one.
3. Edit **Network Settings**:
   - Select the VPC you created earlier.
   - Assign the **public subnet** to the instance.
   - Enable **Auto-assign Public IP** for SSH access.
4. Set up the **Security Group**:
   - Create a new security group and name it appropriately.
   - Add rules to allow the following:
     - **SSH (port 22)**: For remote access.
     - **Custom ICMP-IPv4**: For ping and network communication.
     - **NFS Ports**:
       - TCP 2049, UDP 2049
       - TCP 111, UDP 111
       - TCP 20048
   - Restrict traffic using appropriate CIDR blocks.

<p align="center"><img alt="Security Group Rules" src="../documentation/resources/Screenshot%202024-11-18%20124934.png" width=900 /></p>

5. Configure **Storage**:
   - Allocate at least 6 GiB for the instance.

<p align="center"><img alt="Storage Configuration" src="../documentation/resources/Screenshot%202024-11-18%20130112.png" width=900 /></p>

6. Click **Launch Instance**.

---

## **Step 3: Launching a Compute Node**

The compute node will reside in the **private subnet**, using the NAT gateway for internet access.

### **3.1 Create the Instance**
1. Navigate to the **EC2 Dashboard** and select **Launch Instance**.
2. Configure the instance:
   - **Name**: Compute Node
   - **AMI**: Red Hat Enterprise Linux (RHEL) 9
   - **Instance Type**: t2.micro
   - Use the **key pair** created for the headnode.
3. Edit **Network Settings**:
   - Assign the **private subnet** to the instance.
   - Disable **Auto-assign Public IP**.
   - Use the previously created **security group**.
4. Optional: Set a custom private IP under **Advanced Network Settings**.

<p align="center"><img alt="Compute Node Configuration" src="../documentation/resources/Screenshot%202024-11-18%20133449.png" width=900 /></p>

---

### **Visual Workflow**

#### **VPC Creation**
<p align="center"><img alt="VPC Creation" src="../documentation/resources/Screenshot%202024-11-18%20112515.png" width=900 /></p>

#### **Headnode Configuration**
<p align="center"><img alt="Headnode Configuration" src="../documentation/resources/Screenshot%202024-11-18%20124829.png" width=900 /></p>

#### **Security Group Rules**
<p align="center"><img alt="Security Group Rules" src="../documentation/resources/Screenshot%202024-11-18%20124934.png" width=900 /></p>

#### **Compute Node Configuration**
<p align="center"><img alt="Compute Node Configuration" src="../documentation/resources/Screenshot%202024-11-18%20133449.png" width=900 /></p>

---

## **Summary**
1. Create a custom **VPC** with one public and one private subnet.
2. Launch a **Headnode** instance in the public subnet.
3. Launch a **Compute Node** instance in the private subnet.
4. Configure security groups, key pairs, and subnets for seamless communication between nodes.

Your cluster is now ready for further configurations and workload deployment!

# Terraform Guide

### Deploying a Second Compute Node on AWS with Terraform

This guide walks you through creating a Terraform script to deploy a second compute node on AWS.

---

## **Prerequisites**

Before using Terraform, ensure the following are installed and configured on your local machine:

1. [Download Terraform](https://www.terraform.io/downloads) and install it.
2. [Download and configure AWS CLI](https://aws.amazon.com/cli/) on your machine.

Additionally, you must set up a **Terraform user** in AWS Identity and Access Management (IAM).

---

## **Creating an AWS IAM User**

To create a user account in AWS IAM, follow these steps:

1. Navigate to the AWS Management Console, search for **IAM**, and click to open the IAM dashboard.

   <p align="center">
      <img alt="IAM Dashboard" src="../documentation/resources/Screenshot 2024-11-23 153119.png" width=900 />
   </p>

   > **Note:** In this guide, a user already exists (hence "1 user" is displayed). If you're setting this up for the first time, the count will show as "0 users."

2. Click the **Users** section, then select **Create User** on the right-hand side.

3. Provide a name for the new user:
   
   <p align="center">
      <img alt="Naming the user" src="../documentation/resources/Screenshot 2024-11-23 154358.png" width=900 />
   </p>

4. Assign the user to a group. If you don't have an existing group, create one.

   <p align="center">
      <img alt="Adding the user to a group" src="../documentation/resources/Screenshot 2024-11-23 154850.png" width=900 />
   </p>

5. Review the details and complete the user creation process. 

   Once the user is successfully created, note down the **Access Key ID** and **Secret Access Key**, as these will be used for authentication.

6. Configure these credentials in AWS CLI using the following command:
   ```bash
   aws configure
 ## Creating a Terraform script

You have to create a main.tf file to write(It can be any name of your choice as long as t has the .tf extension)

Run ***terraform init*** command in the root directory to initialize our Terraform project

The terraform script looks like the one below

<p align="center"><img alt="Naming the instance" src="../documentation/resources/Screenshot 2024-11-23 175158.png" width=900 /></p>

> **_NOTE:_** The above picture is my Terraform script therefore yours does not have to look exactly the same 

You can run the command the following command if you want to peview the changes

```bash
   terrafrom plan
```

After writing the script run the following coammand to launch an instance

```bash
   terrafrom apply
   ```


If you want to delete your instance run the following command 

```bash
   terrafrom destroy
```