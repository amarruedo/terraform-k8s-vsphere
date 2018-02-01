
data "template_file" "worker_cloud_config" {
  count = "${var.instance_count}"
  template = "${file("${path.module}/resources/config/cloud.config")}"

  vars {
    vm_hostname = "${var.hostname["${count.index}"]}"
    }
}
