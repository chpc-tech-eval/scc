# Spinning Up a Second Compute Node Using a Snapshot

At this point you are ready to run HPL on your cluster with two compute nodes. From your Virtual Machine dasboard on Azure, navigate to the node which you wish to create a snapshot of and go to `Disk` &rarr; `Name of the actual Disk` &rarr; `+ Create Snapshot` to reach the window shown below:

<img alt="Creating a snapshot." src="./resources/create_snapshot.png"/>

Once there, simply choose an adequate Name for the snapshot, ensure that the *Snapshot Type* is `Full` and click `Review + Create`.
>[!TIP]
> A suitable name for the snapshot would be <b>computenode2</b>


Creating the actual VM from the snapshot requires two more steps. First navigate to the snapshot you just created (should be visible on your Azure Dashboard or simply search for it) and click `+ Create Disk` as shown below. When creating the disk, simply choose an adequate name (no other changes need to be made).

<img alt="Step one of creating the VM." src="./resources/create_disk.png"/>

Then navigate to the newly created disk and click `+ Create VM` as shown below. Ensure that everything is set up as in Tutorial 1, choosing an adequate name once again, and then `Review + Create`.

<img alt="Step two of creating the VM." src="./resources/create_vm.png"/>

Navigate back to the Virtual Machine dashboard and your second compute node should be <b>deployed and running.</b> 


