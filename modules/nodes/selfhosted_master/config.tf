
data "template_file" "master_cloud_config" {
  template = "${file("${path.module}/resources/config/cloud.config")}"

  vars {
    vcenter_server        = "${var.vcenter_server}"
    vcenter_user          = "${var.vcenter_user}"
    vcenter_password      = "${var.vcenter_password}"
    vcenter_sslselfsigned = "${var.vcenter_sslselfsigned}"
    vcenter_datacenter    = "${var.vcenter_datacenter}"
    vcenter_datastore     = "${var.vcenter_datastore}"
    vm_hostname           = "${var.hostname}"
    vcenter_folder        = "${var.vcenter_cluster_folder}"
   }
}
