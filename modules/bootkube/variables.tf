
variable "image_re" {
  type    = "string"
  default = "/^([^/]+/[^/]+/[^/]+):(.*)$/"
}

variable "apiserver_cert_pem" {
  type        = "string"
  description = "The API server certificate in PEM format."
}

variable "apiserver_key_pem" {
  type        = "string"
  description = "The API server key in PEM format."
}

variable "cluster_name" {
  type = "string"
}

variable "service_cidr" {
  type    = "string"
}

variable "cluster_cidr" {
  type    = "string"
}

variable "container_images" {
  description = "Container images to use"
  type        = "map"
}

variable "kube_apiserver_url" {
  description = "URL used to reach kube-apiserver"
  type        = "string"
}

variable "kube_ca_cert_pem" {
  type        = "string"
  description = "The Kubernetes CA in PEM format."
}

variable "kubelet_cert_pem" {
  type        = "string"
  description = "The kubelet certificate in PEM format."
}

variable "kubelet_key_pem" {
  type        = "string"
  description = "The kubelet key in PEM format."
}

variable "etcd_ca_cert_pem" {
  type        = "string"
  description = "external CA certificate"
}

variable "etcd_client_cert_pem" {
  type = "string"
}

variable "etcd_client_key_pem" {
  type = "string"
}

variable "etcd_server_cert_pem" {
  type = "string"
}

variable "etcd_server_key_pem" {
  type = "string"
}

variable "etcd_peer_cert_pem" {
  type = "string"
}

variable "etcd_peer_key_pem" {
  type = "string"
}
