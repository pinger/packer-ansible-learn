terraform {
  required_providers {
    vagrant = {
      source  = "bmatcuk/vagrant"
      version = "~> 4.0.0"
    }
  }
}

resource "null_resource" "build" {
  provisioner "local-exec" {
    command = "../build_box.sh"
    working_dir = "../"
  }
}

resource "vagrant_vm" "jenkins__vm" {
#  name = "jenkins-box"
  vagrantfile_dir = "../vagrant"
  get_ports = true
}
