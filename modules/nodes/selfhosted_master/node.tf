
# vSphere global settings
data "vsphere_datacenter" "dc" {
  name = "${var.vcenter_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vcenter_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.vcenter_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vcenter_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vcenter_machine_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# Define the VM resource
resource "vsphere_virtual_machine" "node" {
 name             = "${var.hostname}"
 folder           = "${var.vcenter_cluster_folder}"
 resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
 datastore_id     = "${data.vsphere_datastore.datastore.id}"

 num_cpus         = "${var.vm_cpu}"
 memory           = "${var.vm_memory}"
 guest_id         = "${var.vm_guest_id}"

 enable_disk_uuid = true

 network_interface {
   network_id     = "${data.vsphere_network.network.id}"
 }

 disk {
    name             = "${var.hostname}.vmdk"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

/*
 disk {
    label            = "disk1"
    name             = "etcd3.vmdk"
    size             = "2"
    attach           = "true"
    path             = "${var.vm_etcd_volume_path}"
    unit_number      = 1
 }
*/

 clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
  }

 extra_config {
    guestinfo.coreos.config.data.encoding = "base64"
    guestinfo.coreos.config.data          = "${base64encode(data.ignition_config.node.rendered)}"
  }
}
