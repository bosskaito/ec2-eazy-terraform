terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"
}
# variables
variable "app" { type = string }
variable "key" { type = string }
variable "region" { type = string }
variable "vpc_cidr_block" { type = string }
variable "subnet_cidr_block1" { type = string }
variable "subnet_cidr_block10" { type = string }
variable "subnet_cidr_block11" { type = string }
variable "ssh_cidr_blocks" {
  type = list
  description = "allowed SSH connection"
  default = ["0.0.0.0/0"]
}
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string }