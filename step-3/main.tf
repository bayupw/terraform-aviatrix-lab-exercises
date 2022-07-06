# Aviatrix VPC Data Source | Transit VPC
data "aviatrix_vpc" "aws_transit" {
  name = "aws-transit"
}

# Create an Aviatrix AWS Transit Network Gateway
resource "aviatrix_transit_gateway" "aws_transit" {
  cloud_type   = 1
  account_name = var.aws_account_name
  gw_name      = "aws-transit"
  vpc_id       = data.aviatrix_vpc.aws_transit.vpc_id
  vpc_reg      = data.aviatrix_vpc.aws_transit.region
  gw_size      = "t3.micro"
  subnet       = data.aviatrix_vpc.aws_transit.public_subnets[0].cidr
  ha_gw_size   = "t3.micro"
  ha_subnet    = data.aviatrix_vpc.aws_transit.public_subnets[2].cidr

  connected_transit = true
}

# Aviatrix VPC Data Source | QA1 Spoke VPC
data "aviatrix_vpc" "aws_qa1_spoke" {
  name = "qa1-spoke-vpc"
}

# Create an Aviatrix AWS Spoke Gateway | QA1 Spoke VPC
resource "aviatrix_spoke_gateway" "qa1_spoke_gw" {
  cloud_type   = 1
  account_name = var.aws_account_name
  gw_name      = "aws-qa1-spoke"
  vpc_id       = data.aviatrix_vpc.aws_qa1_spoke.vpc_id
  vpc_reg      = data.aviatrix_vpc.aws_qa1_spoke.region
  gw_size      = "t3.micro"
  subnet       = data.aviatrix_vpc.aws_qa1_spoke.public_subnets[0].cidr
  ha_gw_size   = "t3.micro"
  ha_subnet    = data.aviatrix_vpc.aws_qa1_spoke.public_subnets[2].cidr
}

# Aviatrix VPC Data Source | QA2 Spoke VPC
data "aviatrix_vpc" "aws_qa2_spoke" {
  name = "qa2-spoke-vpc"
}

# Create an Aviatrix AWS Spoke Gateway | QA2 Spoke VPC
resource "aviatrix_spoke_gateway" "qa2_spoke_gw" {
  cloud_type   = 1
  account_name = var.aws_account_name
  gw_name      = "aws-qa2-spoke"
  vpc_id       = data.aviatrix_vpc.aws_qa2_spoke.vpc_id
  vpc_reg      = data.aviatrix_vpc.aws_qa2_spoke.region
  gw_size      = "t3.micro"
  subnet       = data.aviatrix_vpc.aws_qa2_spoke.public_subnets[0].cidr
  ha_gw_size   = "t3.micro"
  ha_subnet    = data.aviatrix_vpc.aws_qa2_spoke.public_subnets[2].cidr
}

# Create an Aviatrix Spoke Transit Attachment | QA1 to Transit
resource "aviatrix_spoke_transit_attachment" "qa1_transit" {
  spoke_gw_name   = aviatrix_spoke_gateway.qa1_spoke_gw.gw_name
  transit_gw_name = aviatrix_transit_gateway.aws_transit.gw_name

  depends_on = [aviatrix_transit_gateway.aws_transit, aviatrix_spoke_gateway.qa1_spoke_gw]
}

# Create an Aviatrix Spoke Transit Attachment | QA2 to Transit
resource "aviatrix_spoke_transit_attachment" "qa2_transit" {
  spoke_gw_name   = aviatrix_spoke_gateway.qa2_spoke_gw.gw_name
  transit_gw_name = aviatrix_transit_gateway.aws_transit.gw_name

  depends_on = [aviatrix_transit_gateway.aws_transit, aviatrix_spoke_gateway.qa2_spoke_gw]
}