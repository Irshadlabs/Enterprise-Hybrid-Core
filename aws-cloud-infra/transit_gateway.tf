# -----------------------------------------------------------------------------------
# Resource: aws_ec2_transit_gateway & Route Tables
# Description: Defines the central cloud router (TGW) to interconnect multiple VPCs
#              and route traffic back to the On-Premise Cisco Edge network.
# Author:      Mohammed Irshad
# -----------------------------------------------------------------------------------

# 1. Create the Central AWS Transit Gateway
resource "aws_ec2_transit_gateway" "central_tgw" {
  description                     = "Central Hub for Hybrid Cloud Core Routing"
  amazon_side_asn                 = 64512
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = "Core-Central-TGW"
  }
}

# 2. Create a Dedicated Route Table for Corporate On-Premise Traffic
resource "aws_ec2_transit_gateway_route_table" "onprem_tgw_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.central_tgw.id

  tags = {
    Name = "TGW-OnPrem-Route-Table"
  }
}

# 3. Create a Dedicated Route Table for Production Cloud VPC
resource "aws_ec2_transit_gateway_route_table" "prod_tgw_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.central_tgw.id

  tags = {
    Name = "TGW-ProdVPC-Route-Table"
  }
}
