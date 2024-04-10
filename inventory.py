# Path to the Terraform output JSON file
terraform_output_file = "/home/patelvrajeshazure/myagent/_work/1/s/terraform_output.json"

# Read the IP address from the file
with open(terraform_output_file, 'r') as f:
    ip_address = f.read().strip()  # Read the contents of the file as a string and remove leading/trailing whitespace

# Assign other variables as needed
ansible_user = "adminuser"
inventory_file = "inventory.ini"

# Add host to inventory file
with open(inventory_file, 'a') as f:
    f.write(f"{ip_address} ansible_user={ansible_user}\n")
