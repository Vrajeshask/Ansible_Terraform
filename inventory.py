import json

# Path to the Terraform output JSON file
terraform_output_file = "/home/patelvrajeshazure/myagent/_work/1/s/terraform_output.json"

# Read and parse JSON content from the Terraform output file
with open(terraform_output_file, 'r') as f:
    terraform_output = json.load(f)

# Extract the IP address from the parsed JSON
ip_address = terraform_output["vm_ip_address"]

# Assign other variables as needed
ansible_user = "adminuser"
inventory_file = "inventory.ini"

# Add host to inventory file
with open(inventory_file, 'a') as f:
    f.write(f"{ip_address} ansible_user={ansible_user}\n")
