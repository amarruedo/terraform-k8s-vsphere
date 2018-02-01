
resource "template_dir" "bootkube" {
  source_dir                = "${path.module}/resources/manifests"
  destination_dir           = "./generated/manifests"

  vars {
    server                  = "${var.kube_apiserver_url}"
    cluster_name            = "${var.cluster_name}"

    hyperkube_image         = "${var.container_images["hyperkube"]}"
    flannel_image           = "${var.container_images["flannel"]}"
    flannel_cni_image       = "${var.container_images["flannel_cni"]}"
    kubedns_image           = "${var.container_images["kubedns"]}"
    kubednsmasq_image       = "${var.container_images["kubednsmasq"]}"
    kubedns_sidecar_image   = "${var.container_images["kubedns_sidecar"]}"
    pod_checkpointer_image  = "${var.container_images["pod_checkpointer"]}"

    kube_ca_cert            = "${base64encode(var.kube_ca_cert_pem)}"
    apiserver_key           = "${base64encode(var.apiserver_key_pem)}"
    apiserver_cert          = "${base64encode(var.apiserver_cert_pem)}"
    serviceaccount_pub      = "${base64encode(tls_private_key.service_account.public_key_pem)}"
    serviceaccount_key      = "${base64encode(tls_private_key.service_account.private_key_pem)}"
    etcd_ca_cert            = "${base64encode(var.etcd_ca_cert_pem)}"
    etcd_client_cert        = "${base64encode(var.etcd_client_cert_pem)}"
    etcd_client_key         = "${base64encode(var.etcd_client_key_pem)}"

    cluster_cidr            = "${var.cluster_cidr}"
    service_cidr            = "${var.service_cidr}"
  }
}

resource "template_dir" "bootkube_bootstrap" {
  source_dir                = "${path.module}/resources/bootstrap-manifests"
  destination_dir           = "./generated/bootstrap-manifests"

  vars {
    hyperkube_image         = "${var.container_images["hyperkube"]}"
    cluster_cidr            = "${var.cluster_cidr}"
    service_cidr            = "${var.service_cidr}"
  }
}

data "template_file" "kubeconfig" {
  template                  = "${file("${path.module}/resources/auth/kubeconfig")}"

  vars {
    kube_ca_cert            = "${base64encode(var.kube_ca_cert_pem)}"
    kubelet_cert            = "${base64encode(var.kubelet_cert_pem)}"
    kubelet_key             = "${base64encode(var.kubelet_key_pem)}"
    server                  = "${var.kube_apiserver_url}"
    cluster_name            = "${var.cluster_name}"
  }
}

resource "local_file" "kubeconfig" {
  content                   = "${data.template_file.kubeconfig.rendered}"
  filename                  = "./generated/auth/kubeconfig"
}
