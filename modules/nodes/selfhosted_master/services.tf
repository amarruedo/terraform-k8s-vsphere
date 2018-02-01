
data "template_file" "kubelet" {
  template = "${file("${path.module}/resources/services/kubelet")}"

  vars {
    kubelet_image_url      = "${replace(var.container_images["hyperkube"],var.image_re,"$1")}"
    kubelet_image_tag      = "${replace(var.container_images["hyperkube"],var.image_re,"$2")}"
    hostname               = "${var.hostname}"
    node_labels_and_taints = "--node-labels=node-role.kubernetes.io/master"
    }
}

data "template_file" "bootkube" {
  template = "${file("${path.module}/resources/services/bootkube")}"

  vars {
    bootkube_image = "${var.container_images["bootkube"]}"
    }
}

data "template_file" "etcd" {
  template = "${file("${path.module}/resources/services/etcd")}"
}

data "template_file" "kubectl" {
  template = "${file("${path.module}/resources/services/kubectl")}"

  vars {
    hyperkube_version = "${replace(var.container_images["hyperkube"],var.image_re,"$2")}"
  }
}
