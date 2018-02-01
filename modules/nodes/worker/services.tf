
data "template_file" "kubelet" {
  count = "${var.instance_count}"
  template = "${file("${path.module}/resources/services/kubelet")}"

  vars {
    kubelet_image_url      = "${replace(var.container_images["hyperkube"],var.image_re,"$1")}"
    kubelet_image_tag      = "${replace(var.container_images["hyperkube"],var.image_re,"$2")}"
    hostname               = "${var.hostname["${count.index}"]}"
    node_labels_and_taints = "--register-with-taints=node-role.kubernetes.io/master=:NoSchedule"
    }
}
