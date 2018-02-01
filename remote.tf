resource "null_resource" "bootstrap" {
  connection {
    type        = "ssh"
    host        = "${var.master_ip}"
    user        = "core"
    timeout     = "60m"
    private_key = "${file(var.ssh_private_key_path != "" ? pathexpand(var.ssh_private_key_path) : "/dev/null")}"
  }

  provisioner "file" {
    source      = "./generated"
    destination = "/home/core/bootkube"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /opt",
      "sudo rm -rf /opt/bootkube",
      "sudo mv /home/core/bootkube /opt/",
    ]
  }
}
