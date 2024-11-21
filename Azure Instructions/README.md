
# Creating Azure Account

### Steps to creating an Azure Account

Create a free azure account using this link: <a href="https://azure.microsoft.com/en-us/pricing/purchase-options/azure-account?icid=azurefreeaccount">Sign Up for Azure</a>

Once created you should be taken to this page: <img alt="Screenshot of home page on azure." src="./azurehomepage.png"/>

### Generating SSH key

Navigate to SSH keys using the search bar .This page will appear:<img alt="Screenshot of SSH keys page on azure." src="./SSHkeys_page.png"/> Click **Create SSH key.** 

You may need to create a new resource group. Under Resource group simply create a new group with an appropriate name which can be associated with all future tasks for this project. 

Fill in all the fields with your groups information and Upload the newly created public key 'id_ed25519.pub'. <img alt="Creating an SSH key page 1." src="./create_SSHKey.png"/>

Click **review + create.** 
Ensure it passes validation and click create.

<img alt="Creating an SSH key page 2." src="./SSHkey_create.png"/>

The key should then appear on your dashboard.
>[!TIP]
>If it takes time to appear, keep refreshing.

### Launching a New Instances
From the Azure dashboard, go to <ins>Virtual machines -> Create -> Azure virtual machine.</ins>
Within the current window assign an appropriate name which will describe what the VM's intended purpose is meant to be and help you to remember it's primary function.              

>[!TIP]
>In this case, a suitable name for your instance would be <b>headnode</b>.
<img alt="Creating a VM (headnode)." src="./headnode_create.png"/>
Under Resource Group, pick the one created earlier and under Region, pick <b>South Africa.</b>

### Linux Flavours and Distributions
Under Image select the desired distribution.

### Azure Instance Sizes
Under Size click the desired instance size.

### Key Pair 
Still under the Basics tab, associate the SSH Key that you created earlier to your VM, otherwise you will not be able to log into your newly created instance.
<img alt="Key Pair screen." src="./key_pair.png"/>

## Disks,Networking and Security 
### Disks 
Under *Disks*, ensure that the following options are configured:  
1. *OS Disk Type is set to <ins>Standard SSD</ins>,*
2. *Delete with VM is NOT checked*

<img alt="Disks." src="./setting_up_disks.png"/>

### Networking and Security
Under *Networking*, ensure the following options are configured:
1. Virtual network* is set to <b>your team’s network</b> 
2. *Subnet* can be the default 
3. *NIC network security group* is set to <ins>Advanced</ins> and the corresponding group is applied
    
<img alt="Networking and Security." src="./setting_up_network.png"/>

>[!IMPORTANT]
>Verify that your instance was successfully Deployed and Launched
<img alt="Headnode Status." src="./headnode_status.png"/>

# Creating a Snapshot

At this point you are ready to run HPL on your cluster with two compute nodes. From your Virtual Machine dasboard on Azure, navigate to the node which you wish to create a snapshot of. Go to <b><ins> Disk -> Name of the actual Disk -> +Create Snapshot.</ins></b>
<img alt="ComputeNode1 Disks." src="./computenode_disks.png"/>

Once there, simply choose an adequate Name for the snapshot, ensure that the *Snapshot Type* is ‘Full’ and 
click **Review + Create.**

>[!TIP]
> A suitable name for the snapshot would be computenode2

<img alt="Creating a snapshot." src="./create_snapshot.png"/>

Creating the actual VM from the snapshot requires two steps. First navigate to the snapshot and click **+ Create Disk.** 

>[!TIP]
>Simply choose an adequate name (no other changes need to be made) when creating the disk. 

<img alt="Step one of creating the VM." src="./create_disk.png"/>

Then navigate to the newly created disk and click **+ Create VM.** Ensure that everything is set up as in Tutorial 1, choosing an adequate name once again, and then *Review + Create.*

<img alt="Step two of creating the VM." src="./create_vm.png"/>

Navigate back to the Virtual Machine dashboard and your second compute node should be <b>deployed and running.</b> 


