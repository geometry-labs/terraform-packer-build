# terraform-aws-packer-ami

This module runs packer from a terraform module.

## Terraform versions

For Terraform v0.12.0+

## Usage

```hcl-terraform
module "this" {
  source = "github.com/insight-infrastructure/terraform-aws-packer-ami"
}
```

## Examples

- [defaults](https://github.com/geometry-labs/terraform-aws-packer-ami/tree/master/examples/defaults)

## Known issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| local | n/a |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| apply\_always | Bool to make it run even if there is no change in packer conf or vars. | `bool` | `false` | no |
| color | n/a | `bool` | `true` | no |
| create | Bool to create resources | `bool` | `true` | no |
| debug | Disables parallelization and enables debug mode. | `bool` | `false` | no |
| except | Run all the builds and post-processors except this list | `list(string)` | `[]` | no |
| force | Forces a builder to run when artifacts from a previous build prevent a build from running | `bool` | `false` | no |
| on\_error | Selects what to do when the build fails | `string` | `"cleanup"` | no |
| only | Only run the builds with the given comma-separated names | `list(string)` | `[]` | no |
| packer\_config\_path | The abs path to the packer config file | `string` | n/a | yes |
| packer\_vars | A map of variables to use in packer | `map(string)` | `{}` | no |
| parallel\_builds | Limit the number of builds to run in parallel | `number` | `0` | no |
| tags | Tags that are appended | `map(string)` | `{}` | no |
| timestamp\_ui | Enable prefixing of each ui output with an RFC3339 timestamp | `bool` | `false` | no |
| var\_file | JSON file containing user variables | `string` | `""` | no |
| vars | A map of key value pairs to be used as var option | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| packer\_command | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [Geometry Labs](github.com/geometry-labs)

## License

Apache 2 Licensed. See LICENSE for full details.