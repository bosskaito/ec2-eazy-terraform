resource "aws_key_pair" "web_app" {
  key_name   = var.key
  # fileの場所を記載する
  public_key = file("./example.pub(公開鍵)")
}

resource "aws_instance" "web" {
  # AMIのスペック
  ami = data.aws_ssm_parameter.amzn2_ami.value
  # instance_typeはt3.xlarge　以上じゃないとdockerが動かない
  instance_type = "t3.xlarge"
  # PublicIPを付与するか
  associate_public_ip_address = true
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.instance.id]
  # ssh接続する際のkey
  key_name = aws_key_pair.web_app.id
  tags = { Name = var.app }
}

# Elastic_IP
resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = true
}

data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}