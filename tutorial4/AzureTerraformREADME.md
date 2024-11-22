# Automating the Deployment of Your Azure Instances Using Terraform

Terraform is a piece of software that allows one to write out their cloud infrastructure and deployments as code, [IaC](https://en.wikipedia.org/wiki/Infrastructure_as_code). This allows the deployments of your cloud virtual machine instances to be shared, iterated, automated as needed and for software development practices to be applied to your infrastructure.

## Install and Initialize Terraform

You will now prepare, install and initialize Terraform on your head node. You will define and configure a `providers.tf` file, to configure OpenStack instances (as Sebowa is an OpenStack based cloud).

1. Use your operating system's package manager to install Terraform

   This could be your workstation or one of your VMs. The machine must be connected to the internet and have access to your OpenStack workspace, i.e. https://sebowa.nicis.ac.za
   * DNF / YUM
   ```bash
   sudo yum update -y

   # Install package to manage repository configurations
   sudo yum install -y dnf-plugins-core

   # Add the HashiCorp Repo
   sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

   sudo dnf install -y terraform
   ```
   * APT
   ```bash
   # Update package repository
   sudo apt-get update
   sudo apt-get install -y gnupg software-properties-common

   # Add HashiCorp GPG Keys
   wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

   # Add the official HashiCorp Linux Repo
   echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

   ```
   * Pacman
   ```bash
   # Arch
   sudo pacman -S terraform
   ```

1. Create a Terraform directory, descend into it and Edit the `providers.tf` file

   ```bash
   mkdir terraform
   cd terraform
   vim providers.tf
   ```

1. You must specify a [Terraform Provider] 
    These can vary from MS Azure, AWS, Google, Kubernetes etc... We will be implementing an Azure provider. Add the following to the `providers.tf` file.
    ```conf
    terraform {
        required_providers {
        azurem = {
            source = "hashicorp/azurerm"
            version = "~?3.0"
        }
        }
    }
    provider "azurerm"{
        features{}
    }
    ```  
1. Initialize Terraform

   From the folder with your provider definition, execute the following command:
   ```bash
   terraform init
   ```



## Generate authentication and main.tf file

Authenticate yourself against your Azure workspace and generate the `main.tf` file that will define
how your infrastructure should be provisioned.

1. Login to Azure CLI through Powershell

   ```
   az login
   ```
<b>Follow the instructions which appear once running this line as stipulated to authenticate yourself.</b>

>[!IMPORTANT]
>It is possible that your laptops do not have Azure CLI installed already. If not follow the following steps.

1. Import Microsoft GPG key
    ```
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    ```

1. Add Azure CLI repository
    ```
    sudo dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-
    prod.rpm
    ```
1. Install Azure
    ```
    sudo dnf update -y
    sudo dnf install -y azure-cli
    ```
1. Verify Install
    ```
    az--version
    ```
After completing the above steps, you may proceed with the following. 

2. Inside your terraform folder, you must create a `main.tf` file. This is file used to idenitfy the provider to be implemented as well as the copute resource configuration details of the instance we would like to launch.

You will need to define your own `main.tf` file, but below is an example of one such definition:

```
resource &quot;azurerm_resource_group&quot; &quot;example&quot; {
name = &quot;&lt;resources-name&gt;&quot;
location = &quot;South Africa North”
resource &quot;azurerm_virtual_network&quot; &quot;example&quot; {
name = &quot;&lt;vnet-name&gt;&quot;
address_space = [&quot;10.0.0.0/24&quot;]
location = azurerm_resource_group.example.location
resource_group_name = azurerm_resource_group.example.name
}
resource &quot;azurerm_subnet&quot; &quot;example&quot; {
name = &quot;internal&quot;
resource_group_name = azurerm_resource_group.example.name
virtual_network_name = azurerm_virtual_network.example.name
address_prefixes = [&quot;10.0.0.64/26&quot;] #any address within your vnet address space
}
resource &quot;azurerm_public_ip&quot; &quot;example&quot; {
name = &quot;&lt;ip-name&gt;&quot;
resource_group_name = azurerm_resource_group.example.name
location = azurerm_resource_group.example.location
allocation_method = &quot;Static&quot;
tags = {
environment = &quot;Production&quot;
}
}
resource &quot;azurerm_network_interface&quot; &quot;example&quot; {
name = &quot;&lt;nic-name&gt;&quot;
location = azurerm_resource_group.example.location
resource_group_name = azurerm_resource_group.example.name
ip_configuration {
name = &quot;internal&quot;
subnet_id = azurerm_subnet.example.id
private_ip_address_allocation = &quot;Dynamic”
public_ip_address_id = &quot;azurem_pubilc_ip.example.id”
}
}
resource &quot;azurerm_linux_virtual_machine&quot; &quot;example&quot; {
name = &quot;&lt;vm-name&gt;&quot;
resource_group_name = azurerm_resource_group.example.name
location = azurerm_resource_group.example.location
size = &quot;&lt;size-choice&gt;&quot;
admin_username = &quot;&lt;adminuser&gt;&quot;
network_interface_ids = [
azurerm_network_interface.example.id,
]
admin_ssh_key {
username = &quot;&lt;adminuser&gt;&quot;
public_key = file(&quot;&lt;key path&gt;&quot;)
}
os_disk {
caching = &quot;ReadWrite&quot;
storage_account_type = &quot;Standard_LRS&quot;
}
# Pick your preference
source_image_reference {
publisher = &quot;RedHat&quot;
offer = &quot;RHEL&quot;
sku = &quot;9-lvm-gen2&quot;
version = &quot;latest&quot;
}
}
```