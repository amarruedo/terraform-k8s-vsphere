
# Configure the VMware vSphere Provider. ENV Variables set for Username and Passwd.

provider "vsphere" {
 version              = "1.1.0"
 vsphere_server       = "${var.vcenter_server}"
 allow_unverified_ssl = "${var.vcenter_sslselfsigned}"
 user                 = "${var.vcenter_user}"
 password             = "${var.vcenter_password}"
}

data "vsphere_datacenter" "dc" {
  name = "${var.vcenter_datacenter}"
}

# Create the folder
/*
La gestion de la carpeta del cluster queda fuera de Terraform
https://github.com/terraform-providers/terraform-provider-vsphere/issues/219

resource "vsphere_folder" "cluster_folder" {
  datacenter_id       = "${data.vsphere_datacenter.dc.id}"
  path                = "${var.vcenter_cluster_folder}"
  type                = "vm"
}
*/

provider "ignition" {
  version = "1.0.0"
}

provider "null" {
  version = "1.0.0"
}

provider "template" {
  version = "1.0.0"
}
