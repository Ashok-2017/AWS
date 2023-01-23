data "aws_vpcs" "peer" {
  provider = aws.ashok
  filter {
    name = "cidr"
    values = ["10.35.23.0/21"]
  }
}
data "aws_caller_identity" "peer1" {
  provider = aws.vikram
}

#Requester side of the connection
resource "aws_vpc_peering_connection" "peer3" {
  provider = aws.xxxx
  vpc_id = tolist(data.aws_vpcs.peer.ids)[0]
  peer_vpc_id = tolist(data.aws_vpcs.peer.ids)[0]
  peer_owner_id = tolist(data.aws_caller_identity.peer1.account_id)
  auto_accept = false
  
  tags = {
    "side" = "requester"
    "environment" = "staging"
    "Name" = "xxxxx"
  }
}

#Acceptor's side of the connection
resource "aws_vpc_peering_connection_acceptor" "peer4" {
  provider = aws.xxxx
  vpc_peering_connection_id = aws_vpc_peering_connection.peer3.id
  auto_accept               = true

  tags = {
    side            = "accepter"
    "environment"   = "staging"
    "Name"          = ""
  }
}

resource "aws_vpc_peering_connection" "req" {
  provider = aws.r1
  vpc_id = tolist(data.aws_vpcs.ids)[0]
  peer_vpc_id = tolist(data.aws_vpcs.ids)[0]
  peer_owner_id = data.aws_caller_identity.account_id
  auto_accept = false
  
  tags = {
    "side" = "requestor"
    "environment" = "staging"
    "Name" = " "
  }
}

resource "aws_vpc_peering_connection_acceptor" "acceptor" {
  provider = aws.r2
  vpc_peering_connection_id = aws_vpc_peering_connection.id
  auto_accept = true
  
  tags = {
    side = "acceptor"
    "environment" = "dev"
    "Name" = " "
  }
} 


