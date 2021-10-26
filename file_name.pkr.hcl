variable "version" {
    type    = string
    default = ""
  }
  
  locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }
  
  source "vagrant" "dafault" {
    add_force    = true
    communicator = "ssh"
    provider     = "virtualbox"
    source_path  = "ubuntu/focal64"
  }
  
  build {
    sources = ["source.vagrant.dafault"]
  
    provisioner "shell" {
      execute_command = "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
      script = "scripts/ansible.sh"
    }

    provisioner "shell" {
      execute_command = "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
      script = "scripts/setup.sh"
    }

    provisioner "ansible-local" {
      playbook_file = "ansible/main.yml"
      galaxy_file = "ansible/requirements.yml"
    }

    provisioner "shell" {
      execute_command = "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
      script = "scripts/cleanup.sh"
    }
  }