module "rg" {
  source = "../../module/azurerm_resource_group"
  resource_group_name = "rg-prom"
  location = "central india"
}
module "vnet" {
    depends_on = [ module.rg ]
  source = "../../module/azurerm_vnet"
  virtual_network_name = "appvnet"
  address_space = ["10.0.0.0/16"]
  location = "central india"
  resource_group_name = "rg-prom"
}
module "subnet" {
    depends_on = [ module.vnet ]
  source = "../../module/azurerm_subnet"
  subnet_name = "appsubnet"
  resource_group_name = "rg-prom"
  virtual_network_name = "appvnet"
  address_prefixes = ["10.0.0.0/24"]
}

module "pip" {
   depends_on = [ module.rg ]
source = "../../module/azurerm_publicip"
publicip_name = "servervmpublicip"
resource_group_name = "rg-prom"
location = "central india"
}
module "pip1" {
   depends_on = [ module.rg ]
source = "../../module/azurerm_publicip"
publicip_name = "vm1publicip1"
resource_group_name = "rg-prom"
location = "central india"
}
module "pip2" {
   depends_on = [ module.rg ]
source = "../../module/azurerm_publicip"
publicip_name = "vm2publicip1"
resource_group_name = "rg-prom"
location = "central india"
}

module "virtualmachene" {
    depends_on = [ module.subnet ]
    source = "../../module/azurerm_virtual_machene"
  nic_name = "mynic"
  location = "central india"
  resource_group_name = "rg-prom"
  virtual_machene_name = "servervm"
  subnet_name = "appsubnet"
  virtual_network_name = "appvnet"
  publicip_name = "servervmpublicip"
  admin_username = "devops123"
  admin_password = "Devops@1234"
  publisher = "Canonical"
   offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    image_version = "latest"
}
module "virtualmachene1" {
    depends_on = [ module.subnet ]
    source = "../../module/azurerm_virtual_machene"
  nic_name = "mynic1"
  location = "central india"
  resource_group_name = "rg-prom"
  virtual_machene_name = "dev2vm"
  subnet_name = "appsubnet"
  virtual_network_name = "appvnet"
  publicip_name = "vm1publicip1"
  admin_username = "devops123"
  admin_password = "Devops@1234"
  publisher = "Canonical"
   offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    image_version = "latest"
}
module "virtualmachene2" {
    depends_on = [ module.subnet ]
    source = "../../module/azurerm_virtual_machene"
  nic_name = "mynic2"
  location = "central india"
  resource_group_name = "rg-prom"
  virtual_machene_name = "dev1vm"
  subnet_name = "appsubnet"
  virtual_network_name = "appvnet"
  publicip_name = "vm2publicip1"
  admin_username = "devops123"
  admin_password = "Devops@1234"
  publisher = "Canonical"
   offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    image_version = "latest"
}
module "nsg" {
  depends_on = [ module.virtualmachene ]
  source = "../../module/azurerm_nsg"
  nic_name = "mynic"
  location = "central india"
  resource_group_name = "rg-prom"
  nsg_name = "servervmnsg"
}
module "nsg1" {
  depends_on = [ module.virtualmachene1 ]
  source = "../../module/azurerm_nsg"
  nic_name = "mynic1"
  location = "central india"
  resource_group_name = "rg-prom"
  nsg_name = "dev2vmnsg"
}
module "nsg2" {
  depends_on = [ module.virtualmachene2 ]
  source = "../../module/azurerm_nsg"
  nic_name = "mynic2"
  location = "central india"
  resource_group_name = "rg-prom"
  nsg_name = "dev1vmnsg"
}