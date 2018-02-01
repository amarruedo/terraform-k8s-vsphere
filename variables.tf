
# GLobal settings

variable "ssh_authorized_key" {
  type        = "string"
  description = "SSH public key to use as an authorized key. Example: `\"ssh-rsa AAAB3N...\"`"
}

variable "ssh_private_key_path" {
  type        = "string"
  description = "SSH private key file in .pem format corresponding to ssh_authorized_key. If not provided, SSH agent will be used."
  default     = ""
}

# vSphere global settings
variable "vcenter_server" {
  type        = "string"
  description = "vCenter server IP"
}

variable "vcenter_sslselfsigned" {
  type        = "string"
  description = "Is the vCenter certificate Self-Signed? Example: `sslselfsigned = \"true\"` "
}

variable "vcenter_user" {
  type        = "string"
  description = "vCenter user"
}

variable "vcenter_password" {
  type        = "string"
  description = "vCenter password"
}

variable "vcenter_datacenter" {
  type        = "string"
  description = "vSphere Datacenter"
}

variable "vcenter_datastore" {
  type        = "string"
  description = "vSphere Datastore"
}

variable "vcenter_resource_pool"{
  type        = "string"
  description = "vSphere resource pool"
}

variable "vcenter_network"{
  type        = "string"
  description = "vSphere network"
}

variable "vcenter_machine_template"{
  type        = "string"
  description = "Virtual Machine template"
}

variable "vcenter_cluster_folder"{
  type        = "string"
  description = "vSphere folder where k8s cluster machines will be placed"
}

# VM settings
variable "master_cpu"{
  type        = "string"
  description = "Master Virtual Machine cpu"
  default     = "2"
}

variable "master_memory"{
  type        = "string"
  description = "Master Virtual Machine memory"
  default     = "4096"
}

variable "worker_cpu"{
  type        = "string"
  description = "worker Virtual Machine cpu"
  default     = "2"
}

variable "worker_memory"{
  type        = "string"
  description = "worker Virtual Machine memory"
  default     = "4096"
}

variable "vm_guest_id"{
  type        = "string"
  description = "Virtual Machine guest id"
  default     = "other26xLinux64Guest"
}

variable "vm_etcd_volume_path" {
  type        = "string"
  description = "The path to the etcd volume"
}

# k8s settings

variable "node_dns" {
  type        = "string"
  description = "DNS Server to be used by Virtual Machine(s). Multiple DNS servers can be separated by whitespace. Example: `\"192.168.1.1 192.168.2.1\"`"
}

variable "controller_domain" {
  type        = "string"
  description = "The domain name which resolves to controller node(s)"
}

variable "master_ip" {
  type = "string"
  description = <<EOF
  Master node IP Address
EOF
}

variable "master_hostname" {
  type = "string"
  description = <<EOF
   Master node Hostname
EOF
}

variable "master_gateways" {
  type = "map"
  description = <<EOF
  Terraform map of master node(s) network gateway IP, Example:
  master_gateways = {
  "0" = "192.168.246.99"
  "1" = "192.168.246.99"
}
EOF
}

variable "worker_count" {
  type    = "string"
  description = <<EOF
The number of worker nodes to be created.
This applies only to cloud platforms.
EOF
}

variable "worker_ip" {
  type = "map"
  description = <<EOF
  Terraform map of Master node(s) IP Addresses, Example:
  master_ip = {
  "0" = "192.168.246.20/24"
  "1" = "192.168.246.21/24"
}
EOF
}

variable "worker_hostnames" {
  type = "map"
  description = <<EOF
  Terraform map of Master node(s) Hostnames, Example:
  master_hostnames = {
  "0" = "mycluster-master-0"
  "1" = "mycluster-master-1"
}
EOF
}

variable "worker_gateways" {
  type = "map"
  description = <<EOF
  Terraform map of master node(s) network gateway IP, Example:
  master_gateways = {
  "0" = "192.168.246.99"
  "1" = "192.168.246.99"
}
EOF
}
