import json

def add_host_to_inventory(ip_address, ansible_user, inventory_file):
    with open(inventory_file, 'a') as f:
        f.write(f"{ip_address} ansible_user={ansible_user}\n")

# Path to the Terraform output JSON file
terraform_output_file = "/home/patelvrajeshazure/myagent/_work/1/s/terraform_output.json"

# Read the Terraform output JSON file and extract the IP address
with open(terraform_output_file, 'r') as f:
    terraform_output = json.load(f)
    ip_address = terraform_output["vm_ip_address"]

# Assigning other variables
ansible_user = "adminuser"
inventory_file = "/home/patelvrajeshazure/myagent/_work/1/s/inventory.ini"

# Call the function to add the host to the inventory
add_host_to_inventory(ip_address, ansible_user, inventory_file)