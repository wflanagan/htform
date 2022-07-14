

resource "hcloud_server" "dev" {
  count       = var.instances
  name        = "dev-server-test2${count.index}"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [data.hcloud_ssh_key.get_hetzner_key.id]
  labels = {
    type = "dev"
  }
  #user_data = file("bootstrap.sh") # To be used with cloud-init
  #user_data = file("user_data.yml")
}

resource "random_integer" "rand" {
  min = 1000000000
  max = 9999999999
}

data "template_file" "devtools" {
  count    = var.instances
  template = file("${path.module}/userdata/bootstrap.sh")
  vars = {
    nodejs_version           = var.nodejs_version
    ruby_version             = var.ruby_version
    script_loc               = var.script_loc
    asdf_git_repo_url        = var.asdf_git_repo_url
    asdf_nodejs_git_repo_url = var.asdf_nodejs_git_repo_url
    asdf_ruby_git_repo_url   = var.asdf_ruby_git_repo_url
  }
}

resource "null_resource" "install_devtools" {
  depends_on = [
    hcloud_server.dev
  ]
  count = var.instances

  provisioner "file" {
    connection {
      agent       = false
      host        = hcloud_server.dev[count.index % var.instances].ipv4_address
      user        = var.compute_user
      private_key = file(var.hetzner_private_key_path)
    }

    content     = data.template_file.devtools[0].rendered
    destination = "${var.script_loc}/bootstrap_${random_integer.rand.result}.sh"
  }

  provisioner "remote-exec" {
    connection {
      agent       = false
      host        = hcloud_server.dev[count.index % var.instances].ipv4_address
      user        = var.compute_user
      private_key =file(var.hetzner_private_key_path)
    }

    inline = [
      "chmod +x  ${var.script_loc}/bootstrap_${random_integer.rand.result}.sh",
      "while [ ! -f ${var.script_loc}/bootstrap.done ]; do ${var.script_loc}/bootstrap_${random_integer.rand.result}.sh; sleep 10; done",
    ]
  }
}


resource "null_resource" "inject_hetzner_private_key" {
  depends_on = [
    hcloud_server.dev,
    null_resource.install_devtools
  ]
  count = var.instances

  provisioner "file" {
    connection {
      agent       = false
      host        = hcloud_server.dev[count.index % var.instances].ipv4_address
      user        = var.compute_user
      private_key = file(var.hetzner_private_key_path)
    }

    content     = file(var.hetzner_private_key_path)
    destination = var.hetzner_private_key_inject_path
  }

    provisioner "remote-exec" {
    connection {
      agent       = false
      host        = hcloud_server.dev[count.index % var.instances].ipv4_address
      user        = var.compute_user
      private_key =file(var.hetzner_private_key_path)
    }

    inline = [
      "chmod 600  ${var.hetzner_private_key_inject_path}",
    ]
  }
}

