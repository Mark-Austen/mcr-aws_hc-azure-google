resource "aws_vpc" "aws_vpc_1" {
  cidr_block = var.aws_vpc_1_cidr
  
  tags = {
    Name = var.aws_vpc_1_name
  }
}

resource "aws_subnet" "aws_subnet_1" {
  vpc_id                  = aws_vpc.aws_vpc_1.id
  cidr_block              = aws_vpc.aws_vpc_1.cidr_block
  map_public_ip_on_launch = false

  tags = {
    Name = var.aws_subnet_1_name
  }
}

resource "aws_route_table" "aws_route_table_1" {
  vpc_id = aws_vpc.aws_vpc_1.id

  tags = {
    Name = var.aws_route_table_1_name
  }
}

resource "aws_route_table_association" "aws_vpc_1_route_table_association" {
  subnet_id      = aws_subnet.aws_subnet_1.id
  route_table_id = aws_route_table.aws_route_table_1.id
}

resource "aws_vpn_gateway" "aws_vpn_gateway_1" {
  vpc_id = aws_vpc.aws_vpc_1.id

  tags = {
    Name = var.aws_vpn_gateway_1_name
  }
}

resource "aws_dx_gateway" "aws_dx_gateway_1" {
  name            = var.aws_dx_gateway_1_name
  amazon_side_asn = "64512"
}

resource "aws_dx_gateway_association" "dx_gateway_association" {
  dx_gateway_id         = aws_dx_gateway.dx_gateway_1.id
  associated_gateway_id = aws_vpn_gateway.aws_vpn_gateway_1.id
}

resource "aws_dx_connection_confirmation" "confirmation" {
  connection_id = megaport_vxc.aws_vxc_1.csp_connections[1].connection_id
}

resource "aws_dx_private_virtual_interface" "aws_dx_private_virtual_interface_1" {
  connection_id     = megaport_vxc.aws_vxc_1.csp_connections[1].connection_id
  dx_gateway_id     = aws_dx_gateway.aws_dx_gateway_1.id
  name              = var.aws_dx_vif_1_name
  vlan              = megaport_vxc.aws_vxc_1.b_end.vlan
  address_family    = "ipv4"
  bgp_asn           = var.megaport_mcr_1_asn
  customer_address  = var.aws_dx_vif_customer_address
  amazon_address    = var.aws_dx_vif_amazon_address
  bgp_auth_key      = var.megaport_aws_vxc_1_bgp_password

  depends_on = [
    aws_dx_connection_confirmation.confirmation
  ]
}
