output "packer_command" {
  value = data.template_file.command.rendered
}
