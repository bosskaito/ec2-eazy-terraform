resource "aws_route_table_association" "public_route" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public_route.id
}