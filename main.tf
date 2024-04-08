provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "ncpl-rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "ncpl-vn" {
  name                = var.vn_name
  resource_group_name = azurerm_resource_group.ncpl-rg.name
  location            = azurerm_resource_group.ncpl-rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "ncpl-subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.ncpl-rg.name
  virtual_network_name = azurerm_virtual_network.ncpl-vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "ncpl-public_ip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.ncpl-rg.name
  location            = azurerm_resource_group.ncpl-rg.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "ncpl-nsg" {
  name                = "ncpl-nsg"
  location            = azurerm_resource_group.ncpl-rg.location
  resource_group_name = azurerm_resource_group.ncpl-rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Add more security rules as needed
}

resource "azurerm_network_interface" "ncpl-nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.ncpl-rg.location
  resource_group_name = azurerm_resource_group.ncpl-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ncpl-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ncpl-public_ip.id
  }
}
resource "azurerm_network_interface_security_group_association" "ncpl-nic-nsg" {
  network_interface_id      = azurerm_network_interface.ncpl-nic.id
  network_security_group_id = azurerm_network_security_group.ncpl-nsg.id
}

resource "azurerm_linux_virtual_machine" "ncpl-vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.ncpl-rg.name
  location            = azurerm_resource_group.ncpl-rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  disable_password_authentication = true 

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("/home/patelvrajeshazure/.ssh/id_rsa.pub")
  }

  #custom_data = base64encode(file("/home/patelvrajeshazure/myagent/_work/1/s/custom_data.sh"))

  network_interface_ids = [
    azurerm_network_interface.ncpl-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

 provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /home/patelvrajeshazure/.ssh",
      "sudo touch /home/patelvrajeshazure/.ssh/authorized_keys",
      "sudo chmod 700 /home/patelvrajeshazure/.ssh",
      "sudo chmod 600 /home/patelvrajeshazure/.ssh/authorized_keys",
      "sudo cp /home/adminuser/.ssh/authorized_keys /home/patelvrajeshazure/.ssh/",
      "sudo chown -R patelvrajeshazure:patelvrajeshazure /home/patelvrajeshazure/.ssh"
    ]
    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = file("/home/patelvrajeshazure/.ssh/id_rsa")
      host        = azurerm_network_interface.ncpl-nic.private_ip_address
    }
  }
}

output "public_ip_address" {
  value = azurerm_public_ip.ncpl-public_ip.ip_address
}
