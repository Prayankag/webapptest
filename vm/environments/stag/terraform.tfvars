resource_group_name = "vam-rg-stag"
location            = "West US 2"
virtual_network_name  = "stag-vnet"
address_space         = ["10.0.0.0/16"]
subnet_name           = "dev-subnet"
subnet_address_prefix = "10.0.1.0/24"
vm_name               = "stag-vm"
vm_size               = "Standard_DS1_v2"
admin_username     = "adminuser"
admin_password     = "MyP@ssw0rd123!@"
