# terraform-aws-packer-ami

> WIP

## Features

This module runs packer from a terraform module.

> Note: This is an early work and will be evolving to wrap many other packer functions and workflows.

## Terraform versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/insight-infrastructure/terraform-aws-packer-ami"

}
```

## Examples

- [defaults](https://github.com/robc-io/terraform-aws-packer-ami/tree/master/examples/defaults)

## Known issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |
| random | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| distro | The distro, ie - debian-9, ubuntu-18 | `string` | n/a | yes |
| name | n/a | `string` | `"node"` | no |
| node | the node type of node, citizen, p-rep | `string` | n/a | yes |
| packer\_config\_path | The abs path to the packer config file | `string` | n/a | yes |
| packer\_vars | n/a | `map(string)` | `{}` | no |
| tags | Tags that are appended | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| ami\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [robc-io](github.com/robc-io)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.