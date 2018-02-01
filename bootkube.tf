module "kube_certs" {
  source = "modules/tls/kube/self-signed"

  ca_cert_pem        = "${var.ca_cert}"
  ca_key_alg         = "${var.ca_key_alg}"
  ca_key_pem         = "${var.ca_key}"
  kube_apiserver_url = "https://${var.controller_domain}:443"
  service_cidr       = "${var.service_cidr}"
}

module "etcd_certs" {
  source = "modules/tls/etcd/signed"

  etcd_ca_cert_path     = "${var.etcd_ca_cert_path}"
  etcd_client_cert_path = "${var.etcd_client_cert_path}"
  etcd_client_key_path  = "${var.etcd_client_key_path}"
  self_signed           = "${var.self_signed}"
  service_cidr          = "${var.service_cidr}"
}

module "bootkube" {
  source = "modules/bootkube"

  cluster_name         = "${var.cluster_name}"
  kube_apiserver_url   = "https://${var.controller_domain}:443"
  container_images     = "${var.container_images}"
  service_cidr         = "${var.service_cidr}"
  cluster_cidr         = "${var.cluster_cidr}"

  apiserver_cert_pem   = "${module.kube_certs.apiserver_cert_pem}"
  apiserver_key_pem    = "${module.kube_certs.apiserver_key_pem}"
  kube_ca_cert_pem     = "${module.kube_certs.ca_cert_pem}"
  kubelet_cert_pem     = "${module.kube_certs.kubelet_cert_pem}"
  kubelet_key_pem      = "${module.kube_certs.kubelet_key_pem}"
  etcd_ca_cert_pem     = "${module.etcd_certs.etcd_ca_crt_pem}"
  etcd_client_cert_pem = "${module.etcd_certs.etcd_client_crt_pem}"
  etcd_client_key_pem  = "${module.etcd_certs.etcd_client_key_pem}"
  etcd_server_key_pem  = "${module.etcd_certs.etcd_server_key_pem}"
  etcd_server_cert_pem = "${module.etcd_certs.etcd_server_crt_pem}"
  etcd_peer_key_pem    = "${module.etcd_certs.etcd_peer_key_pem}"
  etcd_peer_cert_pem   = "${module.etcd_certs.etcd_peer_crt_pem}"
}
