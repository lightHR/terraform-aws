# --- networking-vpc/output.tf

output "vpc_id" {
  value = aws_vpc.mtc_vpc.id
}