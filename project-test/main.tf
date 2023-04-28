terraform {
  backend "remote" {
    hostname     = "backend.api.env0.com"
    organization = "9edac48b-0c62-45d9-9dfc-131deb39979b"
    workspaces {
      name = "project-test"
    }
  }
}

module "test_module" {
    source = "../modules/test-module"
    
}

output "foo" {
    value = module.test_module.foo
}

resource "null_resource" "aws_cli_version" {
  provisioner "local-exec" {
    command = "which aws"
  }
  triggers = {
    run = "${timestamp()}"
  }
}

resource "null_resource" "aws_cli_version2" {
  provisioner "local-exec" {
    command = "which awsv2"
  }
  triggers = {
    run = "${timestamp()}"
  }
}

resource "null_resource" "path" {
  provisioner "local-exec" {
    command = "echo $PATH"
  }
  triggers = {
    run = "${timestamp()}"
  }
}


resource "null_resource" "kubectl_version" {
  provisioner "local-exec" {
    command = "kubectl version --client"
  }
  triggers = {
    run = "${timestamp()}"
  }
}

resource "null_resource" "python_version" {
  provisioner "local-exec" {
    command = "python3 --version"
  }
  triggers = {
    run = "${timestamp()}"
  }
}
