
# global settings

variable "container_images" {
  description = "Container images to use"
  type        = "map"
}

variable "image_re" {
  description = "(internal) Regular expression used to extract repo and tag components from image strings"
  type        = "string"
}

variable "core_public_keys" {
  type        = "list"
  description = "Public Key for Core User"
}

variable "instance_count" {
  type        = "string"
  description = "Number of nodes to be created."
}

# vSphere global variables

variable "vcenter_server" {
  type       = "string"
  description = "vCenter server IP"
}

variable "vcenter_sslselfsigned" {
  type        = "string"
  description = "Is the vCenter certificate Self-Signed? Example: `sslselfsigned = \"true\"` "
}

variable "vcenter_user" {
  type       = "string"
  description = "vCenter user"
}

variable "vcenter_password" {
  type       = "string"
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

# VM variables
variable "vm_cpu"{
  type        = "string"
  description = "Virtual Machine cpu number"
}

variable "vm_memory"{
  type        = "string"
  description = "Virtual Machine RAM memory"
}

variable "vm_guest_id"{
  type        = "string"
  description = "Virtual Machine guest id"
}

# k8s config variables

variable "dns_server" {
  type        = "string"
  description = "DNS Server of the nodes"
}

variable "gateways" {
  type        = "map"
  description = "Network gateway IP for the node"
}

variable "hostname" {
  type        = "map"
  description = "Hostname of the node"
}

variable "ip_address" {
  type        = "map"
  description = "IP Address of the node"
}

variable "ca_cert_pem" {
  description = "PEM-encoded CA certificate (generated if blank)"
  type        = "string"
}

variable "kubeconfig" {
  description = "Rendered kubeconfig"
  type        = "string"
}
