# -----------------------------------------------------------------------------------
# Resource: aws_customer_gateway & aws_vpn_connection
# Description: Defines the cloud-side endpoints to terminate the IPsec VPN tunnel
#              originating from the Cisco Packet Tracer Edge Router IP.
# Author:      Mohammed Irshad
# -----------------------------------------------------------------------------------

# 1. Register the On-Premise Cisco Router Public IP in AWS
resource "aws_customer_gateway" "cisco_edge" {
  bgp_asn    = 65001
  ip_address = "203.0.113.2" # Maps directly to Cisco Outside WAN Interface
  type       = "ipsec.1"

  tags = {
    Name = "OnPrem-Cisco-Edge-CGW"
  }
}

# 2. Create the Virtual Private Gateway (VGW) for the Target VPC
resource "aws_vpn_gateway" "vpn_gw" {
  amazon_side_asn = 64512
  tags = {
    Name = "Core-Cloud-VGW"
  }
}
