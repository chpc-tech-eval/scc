# Automating the Deployment of Your Azure Instances Using Terraform

Terraform is a piece of software that allows one to write out their cloud infrastructure and deployments as code, [IaC](https://en.wikipedia.org/wiki/Infrastructure_as_code). This allows the deployments of your cloud virtual machine instances to be shared, iterated, automated as needed and for software development practices to be applied to your infrastructure.

## Install and Initialize Terraform

You will now prepare, install and initialize Terraform on your head node and you will define and configure a `providers.tf` file to configure Azure instances.

1. Use your operating system's package manager to install Terraform

   This could be your workstation or one of your VMs. The machine must be connected to the internet and have access to your Azure workspace, i.e. https://portal.azure.com 
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
   nano providers.tf
   ```

1. You must specify a [Terraform Provider](https://registry.terraform.io/browse/providers).
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
<b>Follow the instructions which appear once running this line to authenticate yourself.</b>

>[!IMPORTANT]
>It is possible that your laptops do not have Azure CLI installed already. If not carry out the following steps and attempt logging in again.

<details>
<summary>Install Azure CLI</summary>
   
1. Import Microsoft GPG key
    ```
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    ```

2. Add Azure CLI repository
    ```
    sudo dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-
    prod.rpm
    ```
3. Install Azure
    ```
    sudo dnf update -y
    sudo dnf install -y azure-cli
    ```
4. Verify Install
    ```
    az--version
    ```
After completing the above steps, you may proceed.
</details>

2. Inside your terraform folder, you must create a `main.tf` file. This is a file used to idenitfy the provider to be implemented as well as the copute resource configuration details of the instance we would like to launch.

You will need to define your own `main.tf` file, but below is an example of one such definition:
>[!NOTE]
>Where there is <>, you must specify your own choices

```
resource "azurerm_resource_group" "example" {
    name = "<resources-name>"
    location = "South Africa North”

resource "azurerm_virtual_network" "example" {
    name = "<vnet-name>"
    address_space = ["10.0.0.0/24"]
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example"   {
    name = "internal"
    resource_group_name = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes = ["10.0.0.64/26"] #any address within your vnet address space
}

resource "azurerm_public_ip" "example" {
    name = "<ip-name>"
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    allocation_method = "Static"
    tags = {
        environment = "Production"
    }
}

resource "azurerm_network_interface" "example" {
    name = "<nic-name>"
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name

    ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic”
    public_ip_address_id = "azurem_pubilc_ip.example.id”
    }
}

resource " azurerm_linux_virtual_machine" "example" {
    name = "<vm-name>"
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    size = "<size-choice>"
    admin_username = "<adminuser>"
    network_interface_ids = [
        azurerm_network_interface.example.id,
]

admin_ssh_key {
    username = "<adminuser>"
    public_key = file("<key path>")
}

os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
}

# Pick your preference
source_image_reference {
    publisher = RedHat"
    offer = "RHEL"
    sku = "9-lvm-gen2"
    version = "latest" 
    }
}
```

>[!TIP]
>When choosing your source image, running `az vm image list` is helpful as it displays available and compatible images in your Azure Subscription (and helps with the correct syntax when specifying your `source_image_reference` block)

## Generate, Deploy and Apply Terraform Plan

1. Create a Terraform plan based on the current configuration. This plan will be used to implement changes to your Azure workspace and can be reviewed before applying those changes.
   Generate a plan and write it to disk:
   ```bash
   terraform plan -out ~/terraform/plan
   ```

2. Once you are satisfied with the proposed changes, deploy the terraform plan:
   ```bash
   terraform apply ~terraform/plan
   ```

3. Finally, confirm that your new instance has been successfully created by Terraform. On your Azure workspace, navigate to `Virtual Machines`, refresh the page and your new instance should appear.

> [!TIP]
> To avoid losing your team's progress, it would be a good idea to create a GitHub repo in order for you to commit and push your various scripts and configuration files.
