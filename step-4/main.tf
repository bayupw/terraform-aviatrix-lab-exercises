# Aviatrix VPC Data Source | QA1 Spoke VPC
data "aviatrix_vpc" "aws_qa1_spoke" {
  name = "qa1-spoke-vpc"
}

# Create an Aviatrix AWS Egress FQDN Gateway1
resource "aviatrix_gateway" "aws_qa1_egress1" {
  cloud_type     = 1
  account_name   = var.aws_account_name
  gw_name        = "aws-qa1-egress1"
  vpc_id         = data.aviatrix_vpc.aws_qa1_spoke.vpc_id
  vpc_reg        = data.aviatrix_vpc.aws_qa1_spoke.region
  gw_size        = "t3.micro"
  subnet         = data.aviatrix_vpc.aws_qa1_spoke.public_subnets[0].cidr
  single_ip_snat = false
}

# Create an Aviatrix AWS Egress FQDN Gateway2
resource "aviatrix_gateway" "aws_qa1_egress2" {
  cloud_type     = 1
  account_name   = var.aws_account_name
  gw_name        = "aws-qa1-egress2"
  vpc_id         = data.aviatrix_vpc.aws_qa1_spoke.vpc_id
  vpc_reg        = data.aviatrix_vpc.aws_qa1_spoke.region
  gw_size        = "t3.micro"
  subnet         = data.aviatrix_vpc.aws_qa1_spoke.public_subnets[2].cidr
  single_ip_snat = false
}

# Enable SNAT function of mode "customized_snat" on AWS Egress FQDN Gateway1
resource "aviatrix_gateway_snat" "aws_qa1_egress1_snat" {
  gw_name   = aviatrix_gateway.aws_qa1_egress1.gw_name
  snat_mode = "customized_snat"

  snat_policy {
    src_cidr   = data.aviatrix_vpc.aws_qa1_spoke.cidr
    dst_cidr   = "0.0.0.0/0"
    interface  = "eth0"
    connection = "None"
    protocol   = "all"
    snat_ips   = aviatrix_gateway.aws_qa1_egress1.eip
  }

  depends_on = [aviatrix_gateway.aws_qa1_egress1]
}

# Enable SNAT function of mode "customized_snat" on AWS Egress FQDN Gateway2
resource "aviatrix_gateway_snat" "aws_qa1_egress2_snat" {
  gw_name   = aviatrix_gateway.aws_qa1_egress2.gw_name
  snat_mode = "customized_snat"

  snat_policy {
    src_cidr   = data.aviatrix_vpc.aws_qa1_spoke.cidr
    dst_cidr   = "0.0.0.0/0"
    interface  = "eth0"
    connection = "None"
    protocol   = "all"
    snat_ips   = aviatrix_gateway.aws_qa1_egress2.eip
  }

  depends_on = [aviatrix_gateway.aws_qa1_egress2]
}
