# Create an Azure VNet
resource "aviatrix_vpc" "azure_transit" {
  cloud_type           = 8
  account_name         = var.azure_account_name
  region               = var.azure_region
  name                 = "azure-transit"
  cidr                 = "10.2.0.0/23"
  aviatrix_firenet_vpc = true
}

# Create an Aviatrix Azure Transit Network Gateway
resource "aviatrix_transit_gateway" "azure_transit" {
  cloud_type             = 8
  account_name           = var.azure_account_name
  gw_name                = "azure-transit"
  vpc_id                 = aviatrix_vpc.azure_transit.vpc_id
  vpc_reg                = aviatrix_vpc.azure_transit.region
  gw_size                = "Standard_B1ms"
  subnet                 = aviatrix_vpc.azure_transit.public_subnets[0].cidr
  ha_gw_size             = "Standard_B1ms"
  ha_subnet              = aviatrix_vpc.azure_transit.public_subnets[2].cidr
  connected_transit      = true
  enable_transit_firenet = true
}