

variable "tags" {
  description = "Tags that are appended"
  type        = map(string)
  default     = {}
}

variable "packer_config_path" {
  description = "The abs path to the packer config file"
  type        = string
}


variable "timestamp_ui" {
  description = "Enable prefixing of each ui output with an RFC3339 timestamp"
  type        = bool
  default     = false
}
variable "parallel_builds" {
  description = "Limit the number of builds to run in parallel"
  type        = number
  default     = 0
}

variable "color" {
  description = ""
  type        = bool
  default     = true
}


variable "debug" {
  description = "Disables parallelization and enables debug mode. "
  type        = bool
  default     = false
}

variable "except" {
  description = "Run all the builds and post-processors except this list"
  type        = list(string)
  default     = []
}

variable "force" {
  description = "Forces a builder to run when artifacts from a previous build prevent a build from running"
  type        = bool
  default     = false
}
variable "on_error" {
  description = "Selects what to do when the build fails"
  type        = string
  default     = "cleanup"
}

variable "only" {
  description = "Only run the builds with the given comma-separated names"
  type        = list(string)
  default     = []
}

variable "vars" {
  description = "A map of key value pairs to be used as var option"
  type        = map(string)
  default     = {}
}

variable "var_file" {
  description = "JSON file containing user variables"
  type        = string
  default     = ""
}

variable "packer_vars" {
  description = "A map of variables to use in packer"
  type        = map(string)
  default     = {}
}
