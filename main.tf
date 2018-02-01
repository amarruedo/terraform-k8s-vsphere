
module "masters" {
  source                    = "./modules/nodes/selfhosted_master"

  hostname                  = "${var.master_hostname}"
  dns_server                = "${var.node_dns}"
  ip_address                = "${var.master_ip}"
  gateways                  = "${var.master_gateways}"
  core_public_keys          = ["${var.ssh_authorized_key}"]

  container_images          = "${var.container_images}"
  image_re                  = "${var.image_re}"

  vcenter_server            = "${var.vcenter_server}"
  vcenter_sslselfsigned     = "${var.vcenter_sslselfsigned}"
  vcenter_user              = "${var.vcenter_user}"
  vcenter_password          = "${var.vcenter_password}"
  vcenter_datacenter        = "${var.vcenter_datacenter}"
  vcenter_datastore         = "${var.vcenter_datastore}"
  vcenter_resource_pool     = "${var.vcenter_resource_pool}"
  vcenter_network           = "${var.vcenter_network}"
  vcenter_machine_template  = "${var.vcenter_machine_template}"
  vcenter_cluster_folder    = "${var.vcenter_cluster_folder}"

  vm_cpu                    = "${var.master_cpu}"
  vm_memory                 = "${var.master_memory}"
  vm_guest_id               = "${var.vm_guest_id}"
  vm_etcd_volume_path       = "${var.vm_etcd_volume_path}"

  etcd_ca_cert_pem          = "${module.etcd_certs.etcd_ca_crt_pem}"
  etcd_client_cert_pem      = "${module.etcd_certs.etcd_client_crt_pem}"
  etcd_client_key_pem       = "${module.etcd_certs.etcd_client_key_pem}"
  etcd_server_key_pem       = "${module.etcd_certs.etcd_server_key_pem}"
  etcd_server_cert_pem      = "${module.etcd_certs.etcd_server_crt_pem}"
  etcd_peer_key_pem         = "${module.etcd_certs.etcd_peer_key_pem}"
  etcd_peer_cert_pem        = "${module.etcd_certs.etcd_peer_crt_pem}"

  ca_cert_pem               = "${module.kube_certs.ca_cert_pem}"
  kubeconfig                = "${module.bootkube.kubeconfig}"
}

module "workers" {
  source                    = "./modules/nodes/worker"

  instance_count            = "${var.worker_count}"
  hostname                  = "${var.worker_hostnames}"
  dns_server                = "${var.node_dns}"
  ip_address                = "${var.worker_ip}"
  gateways                  = "${var.worker_gateways}"
  core_public_keys          = ["${var.ssh_authorized_key}"]

  container_images          = "${var.container_images}"
  image_re                  = "${var.image_re}"

  vcenter_server            = "${var.vcenter_server}"
  vcenter_sslselfsigned     = "${var.vcenter_sslselfsigned}"
  vcenter_user              = "${var.vcenter_user}"
  vcenter_password          = "${var.vcenter_password}"
  vcenter_datacenter        = "${var.vcenter_datacenter}"
  vcenter_datastore         = "${var.vcenter_datastore}"
  vcenter_resource_pool     = "${var.vcenter_resource_pool}"
  vcenter_network           = "${var.vcenter_network}"
  vcenter_machine_template  = "${var.vcenter_machine_template}"
  vcenter_cluster_folder    = "${var.vcenter_cluster_folder}"

  vm_cpu                    = "${var.worker_cpu}"
  vm_memory                 = "${var.worker_memory}"
  vm_guest_id               = "${var.vm_guest_id}"

  ca_cert_pem               = "${module.kube_certs.ca_cert_pem}"
  kubeconfig                = "${module.bootkube.kubeconfig}"
}
