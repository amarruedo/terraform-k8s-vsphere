
## Files

# System files

data "ignition_networkd_unit" "vmnetwork" {
  name  = "00-ens192.network"

  content = <<EOF
  [Match]
  Name=ens192
  [Network]
  DNS=${var.dns_server}
  Address=${var.ip_address}/24
  Gateway=${var.gateways["${count.index}"]}
  DHPC=no
EOF
}

data "ignition_file" "node_hostname" {
  path       = "/etc/hostname"
  mode       = 0644
  filesystem = "root"

  content {
    content = "${var.hostname}"
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
  path       = "/etc/kubernetes/cloud/config"
  mode       = 0644
  filesystem = "root"

  content {
    content = "${data.template_file.master_cloud_config.rendered}"
  }
}

# etcd files

data "ignition_file" "etcd_ca" {
  path       = "/etc/ssl/etcd/ca.crt"
  mode       = 0644
  uid        = 232
  gid        = 232
  filesystem = "root"

  content {
    content = "${var.etcd_ca_cert_pem}"
  }
}

data "ignition_file" "etcd_client_key" {
  path       = "/etc/ssl/etcd/client.key"
  mode       = 0400
  uid        = 0
  gid        = 0
  filesystem = "root"

  content {
    content = "${var.etcd_client_key_pem}"
  }
}

data "ignition_file" "etcd_client_crt" {
  path       = "/etc/ssl/etcd/client.crt"
  mode       = 0400
  uid        = 0
  gid        = 0
  filesystem = "root"

  content {
    content = "${var.etcd_client_cert_pem}"
  }
}

data "ignition_file" "etcd_server_key" {
  path       = "/etc/ssl/etcd/server.key"
  mode       = 0400
  uid        = 232
  gid        = 232
  filesystem = "root"

  content {
    content = "${var.etcd_server_key_pem}"
  }
}

data "ignition_file" "etcd_server_crt" {
  path       = "/etc/ssl/etcd/server.crt"
  mode       = 0400
  uid        = 232
  gid        = 232
  filesystem = "root"

  content {
    content = "${var.etcd_server_cert_pem}"
  }
}

data "ignition_file" "etcd_peer_key" {
  path       = "/etc/ssl/etcd/peer.key"
  mode       = 0400
  uid        = 232
  gid        = 232
  filesystem = "root"

  content {
    content = "${var.etcd_peer_key_pem}"
  }
}

data "ignition_file" "etcd_peer_crt" {
  path       = "/etc/ssl/etcd/peer.crt"
  mode       = 0400
  uid        = 232
  gid        = 232
  filesystem = "root"

  content {
    content = "${var.etcd_peer_cert_pem}"
  }
}

# K8s files

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

## Services

data "ignition_systemd_unit" "kubelet" {
  name    = "kubelet.service"
  enabled = true
  content = "${data.template_file.kubelet.*.rendered[count.index]}"
}

data "ignition_systemd_unit" "bootkube" {
  name    = "bootkube.service"
  enabled = true
  content = "${data.template_file.bootkube.*.rendered[count.index]}"
}

data "ignition_systemd_unit" "kubectl" {
  name    = "kubectl.service"
  enabled = true
  content = "${data.template_file.kubectl.rendered}"
}

data "ignition_systemd_unit" "etcd" {
  name    = "etcd-member.service"
  enabled = true

  dropin = [
    {
      name    = "40-etcd-cluster.conf"
      content = "${data.template_file.etcd.rendered}"
    },
  ]
}

## Users

data "ignition_user" "core" {
  name                = "core"
  ssh_authorized_keys = ["${var.core_public_keys}"]
}

## Ignition config

data "ignition_config" "node" {

  users = [
    "${data.ignition_user.core.id}",
  ]

  files = [
    "${data.ignition_file.node_hostname.id}",
    "${data.ignition_file.update.id}",
    "${data.ignition_file.node_cloud_config.id}",
    "${data.ignition_file.etcd_ca.id}",
    "${data.ignition_file.etcd_client_key.id}",
    "${data.ignition_file.etcd_client_crt.id}",
    "${data.ignition_file.etcd_server_key.id}",
    "${data.ignition_file.etcd_server_crt.id}",
    "${data.ignition_file.etcd_peer_key.id}",
    "${data.ignition_file.etcd_peer_crt.id}",
    "${data.ignition_file.ca_pem.id}",
    "${data.ignition_file.kubeconfig.id}",
  ]

  systemd = ["${compact(list(
    "${data.ignition_systemd_unit.kubelet.id}",
    "${data.ignition_systemd_unit.bootkube.id}",
    "${data.ignition_systemd_unit.kubectl.id}",
    "${data.ignition_systemd_unit.etcd.id}",
    ))}"]

  networkd = [
    "${data.ignition_networkd_unit.vmnetwork.id}"
  ]
}
