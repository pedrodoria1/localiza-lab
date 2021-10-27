resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = aws_vpc.vpc_network_aws.id
}

resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65300
  ip_address = "1.1.1.1"
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway.id
  customer_gateway_id = aws_customer_gateway.customer_gateway.id
  type                = "ipsec.1"
  static_routes_only  = true
}

#Rotas pela VPN

resource "aws_vpn_connection_route" "route-to-gcp" {
  destination_cidr_block = "10.0.0.0/8"
  vpn_connection_id      = aws_vpn_connection.main.id
}