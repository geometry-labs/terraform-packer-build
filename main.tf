data "aws_caller_identity" "this" {}
data "aws_region" "current" {}

terraform {
  required_version = ">= 0.12"
}

locals {
  common_tags = {
    "Name" = var.name
    "Terraform"   = true
  }

  tags = merge(var.tags, local.common_tags)
}

resource random_pet "this" {}

data template_file "var_file" {
  template = jsonencode(merge(var.packer_vars, {"distro" = var.distro}, {"node" = var.node}))
}

resource "null_resource" "write_cfg" {
  triggers = {
    appply_time = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
echo '${data.template_file.var_file.rendered}' >> ${path.module}/vars.json
EOT
  }
}

resource "null_resource" "this" {
  triggers = {
    apply_time = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
packer build \
%{ if var.packer_vars != {} }-var-file='${path.module}/vars.json'%{ endif } \
${var.packer_config_path}
EOT
  }
  depends_on = [null_resource.write_cfg]
}

data "aws_ami" "ami_id" {
  most_recent = true

  tags = {
    Name   = var.node
    Distro = var.distro
  }

  owners = ["self"]

  depends_on = [null_resource.this]
}

