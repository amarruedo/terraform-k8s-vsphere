
variable "image_re" {
  description = <<EOF
(internal) Regular expression used to extract repo and tag components
EOF

  type    = "string"
  default = "/^([^/]+/[^/]+/[^/]+):(.*)$/"
}

variable "container_images" {
  description = "(internal) Container images to use"
  type        = "map"

  default = {
    hyperkube                    = "gcr.io/google_containers/hyperkube:v1.8.5"
    bootkube                     = "quay.io/coreos/bootkube:v0.9.1"
    flannel                      = "quay.io/coreos/flannel:v0.9.1-amd64"
    flannel_cni                  = "quay.io/coreos/flannel-cni:v0.3.0"
    kubedns                      = "gcr.io/google_containers/k8s-dns-kube-dns-amd64:1.14.5"
    kubednsmasq                  = "gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64:1.14.5"
    kubedns_sidecar              = "gcr.io/google_containers/k8s-dns-sidecar-amd64:1.14.5"
    kenc                         = "quay.io/coreos/kenc:0.0.2"
    pod_checkpointer             = "quay.io/coreos/pod-checkpointer:08fa021813231323e121ecca7383cc64c4afe888"
  }
}

variable "versions" {
  description = "(internal) Versions of the components to use"
  type        = "map"

  default = {
    etcd          = "3.2.9"
    kubernetes    = "1.8.5"
    bootkube      = "0.9.1"
  }
}

variable "self_signed" {
  type    = "string"
  default = "true"
}

variable "ca_cert" {
  type    = "string"
  default = ""

  description = <<EOF
(optional) The content of the PEM-encoded CA certificate.
If left blank, a CA certificate will be automatically generated.
EOF
}

variable "ca_key" {
  type    = "string"
  default = ""

  description = <<EOF
(optional) The content of the PEM-encoded CA key.
This field is mandatory if `tectonic_ca_cert` is set.
EOF
}

variable "ca_key_alg" {
  type    = "string"
  default = "RSA"

  description = <<EOF
(optional) The algorithm used to generate ca_key.
The default value is currently recommended.
This field is mandatory if `ca_cert` is set.
EOF
}

variable "etcd_ca_cert_path" {
  type    = "string"
  default = "/dev/null"

  description = "(optional) The path of the file containing the CA certificate for TLS communication with etcd."
}

variable "etcd_client_cert_path" {
  type    = "string"
  default = "/dev/null"

  description = "(optional) The path of the file containing the client certificate for TLS communication with etcd."
}

variable "etcd_client_key_path" {
  type    = "string"
  default = "/dev/null"

  description = "(optional) The path of the file containing the client key for TLS communication with etcd."
}

variable "cluster_name" {
  type = "string"
  default = "local"

  description = <<EOF
The name of the cluster.
EOF
}

variable "service_cidr" {
  type    = "string"
  default = "10.3.0.0/16"

  description = <<EOF
(optional) This declares the IP range to assign Kubernetes service cluster IPs in CIDR notation.
The maximum size of this IP range is /12
EOF
}

variable "cluster_cidr" {
  type    = "string"
  default = "10.2.0.0/16"

  description = "(optional) This declares the IP range to assign Kubernetes pod IPs in CIDR notation."
}
