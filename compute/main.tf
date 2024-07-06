# ---  compute/main.tf ---

data "aws_ami" "server_ami" {
    most_recent = true
    owner = ["099720109477"]
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
        }
}