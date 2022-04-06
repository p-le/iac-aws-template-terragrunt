resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "${var.service}-ig"
  }
}

resource "aws_route_table" "public" {
  for_each = toset(data.aws_availability_zones.available.names)
  vpc_id   = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    "Name" = "${var.service}-${each.key}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = toset(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.public[each.value].id
  route_table_id = aws_route_table.public[each.value].id
}


resource "aws_route_table" "private" {
  for_each = toset(data.aws_availability_zones.available.names)
  vpc_id   = aws_vpc.main.id

  tags = {
    "Name" = "${var.service}-${each.key}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = toset(data.aws_availability_zones.available.names)
  subnet_id      = aws_subnet.private[each.value].id
  route_table_id = aws_route_table.private[each.value].id
}
