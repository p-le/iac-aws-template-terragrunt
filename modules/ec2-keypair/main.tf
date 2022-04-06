data "aws_secretsmanager_secret_version" "ssh_key" {
  secret_id = var.ssh_key_secret_id
}

resource "aws_key_pair" "ec2" {
  key_name   = "${var.service}-${var.region}-eks-node-keypair"
  public_key = data.aws_secretsmanager_secret_version.ssh_key.secret_string
}

output "key_name" {
  value = aws_key_pair.ec2.key_name
}
