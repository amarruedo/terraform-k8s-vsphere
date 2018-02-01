
output "kubeconfig" {
  value = "${data.template_file.kubeconfig.rendered}"
}

/*
output "bootstrap_apiserver" {
  value = "${data.template_file.bootstrap_apiserver.rendered}"
}

output "bootstrap_controller" {
  value = "${data.template_file.bootstrap_controller.rendered}"
}

output "bootstrap_scheduler" {
  value = "${data.template_file.bootstrap_scheduler.rendered}"
}

output "apiserver_secret" {
  value = "${data.template_file.apiserver_secret.rendered}"
}

output "apiserver" {
  value = "${data.template_file.apiserver.rendered}"
}

output "controller_manager_disruption" {
  value = "${data.template_file.controller_manager_disruption.rendered}"
}

output "controller_manager_secret" {
  value = "${data.template_file.controller_manager_secret.rendered}"
}

output "controller_manager" {
  value = "${data.template_file.controller_manager.rendered}"
}

output "dns" {
  value = "${data.template_file.dns.rendered}"
}

output "dns_svc" {
  value = "${data.template_file.dns_svc.rendered}"
}

output "flannel_cfg" {
  value = "${data.template_file.flannel_cfg.rendered}"
}

output "flannel" {
  value = "${data.template_file.flannel.rendered}"
}

output "proxy_role_binding" {
  value = "${data.template_file.proxy_role_binding.rendered}"
}

output "proxy_sa" {
  value = "${data.template_file.proxy_sa.rendered}"
}

output "proxy" {
  value = "${data.template_file.proxy.rendered}"
}

output "scheduler_disruption" {
  value = "${data.template_file.scheduler_disruption.rendered}"
}

output "scheduler" {
  value = "${data.template_file.scheduler.rendered}"
}

output "system_rbac_role_binding" {
  value = "${data.template_file.system_rbac_role_binding.rendered}"
}

output "kubeconfig_in_cluster" {
  value = "${data.template_file.kubeconfig_in_cluster.rendered}"
}

output "pod_checkpointer_role_binding" {
  value = "${data.template_file.pod_checkpointer_role_binding.rendered}"
}

output "pod_checkpointer_role" {
  value = "${data.template_file.pod_checkpointer_role.rendered}"
}

output "pod_checkpointer_sa" {
  value = "${data.template_file.pod_checkpointer_sa.rendered}"
}

output "pod_checkpointer" {
  value = "${data.template_file.pod_checkpointer.rendered}"
}
*/
