<img alt="Diagram loosely describing process behind browsing to Google.com. You have no information about the computers and servers behind 72.14.222.1, just as Google has no information about your workstation’s internal IP." src="./resources/browsing_internet_light.png" />

<b>Step 1: Creating Azure Account</b>

Create a free azure account using this link: <a href="https://azure.microsoft.com/en-us/pricing/purchase-options/azure-account?icid=azurefreeaccount">Sign Up for Azure</a>

Once created you should be taken to this page: <img alt="Screenshot of home page on azure." src="./azurehomepage.png"/>

<b>Step 2:Generating SSH keys</b>

Navigate to SSH keys using the search bar .This page will appear:<img alt="Screenshot of SSH keys page on azure." src="./SSHkeys_page.png"/> click Create SSH key. 

You may need to create a new resource group. Under Resource group simply create a new group with an appropriate name which can be associated with all future tasks for this project. 

Fill in all the fields with your groups information and Upload the newly created public key 'id_ed25519.pub'. <img alt="Creating an SSH key page." src="./create_SSHKey.png"/>
Click review + create. Ensure it passes validation and click create.<img alt="Creating an SSH key page." src="./SSHKey_create.png"/>
The key should then appear on your dashboard (if it takes time to appear, keep refreshing).
