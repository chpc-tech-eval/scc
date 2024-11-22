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