# Create an AWS VPC | Transit VPC
resource "aviatrix_vpc" "aws_transit" {
  cloud_type           = 1
  account_name         = var.aws_account_name
  region               = var.aws_region
  name                 = "aws-transit"
  cidr                 = "10.1.0.0/23"
  aviatrix_transit_vpc = true
  aviatrix_firenet_vpc = false
}

# Create an AWS VPC | QA1 Spoke VPC
resource "aviatrix_vpc" "aws_qa1_spoke" {
  cloud_type           = 1
  account_name         = var.aws_account_name
  region               = var.aws_region
  name                 = "qa1-spoke-vpc"
  cidr                 = "10.1.2.0/24"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}

# Create an AWS VPC | QA2 Spoke VPC
resource "aviatrix_vpc" "aws_qa2_spoke" {
  cloud_type           = 1
  account_name         = var.aws_account_name
  region               = var.aws_region
  name                 = "qa2-spoke-vpc"
  cidr                 = "10.1.3.0/24"
  aviatrix_transit_vpc = false
  aviatrix_firenet_vpc = false
}