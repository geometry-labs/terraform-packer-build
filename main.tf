terraform {
  required_version = ">= 0.12"
}

data template_file "var_file" {
  count    = length(var.packer_vars) > 0 ? 1 : 0
  template = jsonencode(var.packer_vars)
}

resource "local_file" "var_file" {
  count    = length(var.packer_vars) > 0 ? 1 : 0
  content  = flatten(data.template_file.var_file[*].rendered)
  filename = "${path.module}/var_file.json"
}

data "template_file" "command" {
  template = <<-EOT
packer build \
%{if var.on_error != "cleanup"}-on-error=${var.on_error}%{endif} \
%{if ! var.color}-color=false%{endif} \
%{if var.debug}-debug%{endif} \
%{if length(var.except) > 0}-except=${join(",", var.except)}%{endif} \
%{if var.force}-force%{endif} \
%{if length(var.only) > 0}-only=${join(",", var.only)}%{endif} \
%{if var.parallel_builds > 0}-parallel-builds=${var.parallel_builds}%{endif} \
%{if var.timestamp_ui}-timestamp-ui%{endif} \
%{if length(var.vars) > 0}%{for k, v in var.vars}-var '${k}=${v}' %{endfor}%{endif} \
%{if length(var.packer_vars) > 0}-var-file='${path.module}/var_file.json'%{endif} \
%{if var.var_file != ""}-var-file=${var.var_file}%{endif} \
${var.packer_config_path}
EOT
}

resource "null_resource" "this" {
  count = var.create ? 1 : 0

  triggers = {
    apply_time    = var.apply_always ? timestamp() : "Don't diff"
    packer_config = filesha1(var.packer_config_path)
    var_file      = join("", local_file.var_file.*.content_base64)
    command       = join("", data.template_file.command.*.rendered)
  }

  provisioner "local-exec" {
    command = data.template_file.command.rendered
  }

  depends_on = [local_file.var_file]
}
