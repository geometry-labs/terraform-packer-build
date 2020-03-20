
variable "diff" {
  default = "bar"
}

module "defaults" {
  source             = "../.."
  packer_config_path = "${path.module}/packer.json"
  timestamp_ui       = true
  vars = {
    stuff = "things"
    foo   = var.diff
  }
}

output "cmd" {
  value = module.defaults.packer_command
}