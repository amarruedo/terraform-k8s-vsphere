
#Define ignition data
data "ignition_networkd_unit" "vmnetwork" {
  count = "${var.instance_count}"
  name  = "00-ens192.network"

  content = <<EOF
  [Match]
  Name=ens192
  [Network]
  DNS=${var.dns_server}
  Address=${var.ip_address["${count.index}"]}/24
  Gateway=${var.gateways["${count.index}"]}
  DHPC=no
EOF
}

data "ignition_file" "node_hostname" {
  count      = "${var.instance_count}"
  path       = "/etc/hostname"
  mode       = 0644
  filesystem = "root"

  content {
    content = "${var.hostname["${count.index}"]}"
  }
}

data "ignition_file" "update" {
  path       = "/etc/coreos/update.conf"
  mode       = 0644
  filesystem = "root"

  content {
    content = "GROUP=stable\nREBOOT_STRATEGY=off\n"
  }
}

data "ignition_file" "node_cloud_config" {
  count      = "${var.instance_count}"
  path       = "/etc/kubernetes/cloud/config"
  mode       = 0644
  filesystem = "root"

  content {
    content = "${data.template_file.worker_cloud_config.*.rendered["${count.index}"]}"
  }
}

data "ignition_file" "ca_pem" {
  path       = "/etc/kubernetes/ca.crt"
  mode       = 0644
  filesystem = "root"

  content {
    content = "${var.ca_cert_pem}"
  }
}

data "ignition_file" "kubeconfig" {
  path       = "/etc/kubernetes/kubeconfig"
  mode       = 0644
  filesystem = "root"

  content {
    content = "${var.kubeconfig}"
  }
}

data "ignition_systemd_unit" "kubelet" {
  count   = "${var.instance_count}"
  name    = "kubelet.service"
  enabled = true
  content = "${data.template_file.kubelet.*.rendered[count.index]}"
}

data "ignition_user" "core" {
  name                = "core"
  ssh_authorized_keys = ["${var.core_public_keys}"]
}

data "ignition_config" "node" {
  count = "${var.instance_count}"

  users = [
    "${data.ignition_user.core.id}",
  ]

  files = [
    "${data.ignition_file.node_hostname.*.id[count.index]}",
    "${data.ignition_file.update.id}",
    "${data.ignition_file.node_cloud_config.*.id[count.index]}",
    "${data.ignition_file.ca_pem.id}",
    "${data.ignition_file.kubeconfig.id}",
  ]

  systemd = ["${compact(list(
    "${data.ignition_systemd_unit.kubelet.*.id[count.index]}",
    ))}"]

  networkd = [
    "${data.ignition_networkd_unit.vmnetwork.*.id[count.index]}"
  ]
}
