variable "project_id" {}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-a"
}
variable "vm_name" {
  default = "my-devops-vm"
}
variable "machine_type" {
  default = "e2-medium"
}
variable "vm_user" {
  default = "ubuntu"
}
variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
