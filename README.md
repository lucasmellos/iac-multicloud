# SignalWire Infrastructure Lives

This repo is the backbone of SignalWire live infrastrcture. It's powered by Terraform and Terragrunt.

Terraform is a IaC tool and Terragrunt is Terraform wrapper to keep code DRY.

The code has been designed to store state files remotely on AWS.

The repo follow an organization pattern being:

```bash
.
|-- ./README.md
|-- ./terragrunt.hcl # Remote state configuration
`-- ./environment
    |-- ./environment/environment.hcl # Environment variables
    |-- ./environment/cloud_provider 
    |   |-- ./environment/cloud_provider
    |   `-- ./environment/cloud_provider/region
        |   |-- ./environment/cloud_provider/region/region.hcl # Cloud Provider Region variables
        |   |-- ./environment/cloud_provider/region/resource_class
        |   |   |-- ./environment/cloud_provider/region/resource_class/resource_type
        |   |   `-- ./environment/cloud_provider/region/resource_class/resource_type/application
        |   `-- ./environment/cloud_provider/region/_common
        |       `-- ./environment/cloud_provider/region/_common/resource_type 
        |           `-- ./environment/cloud_provider/region/resource_type/terragrunt.hcl # Resource definition
        |-- ./environment/cloud_provider/_common 
        |   |-- ./environment/cloud_provider/_common/resource_type
        |   |   `-- ./environment/cloud_provider/_common/resource_type/terragrunt.hcl # Resource definition
            
```

A real example 
```bash
.
|-- ./README.md
|-- ./terragrunt.hcl # Remote state configuration
`-- ./staging # Environment
    |-- ./staging/environment.hcl # Environment variables
    `-- ./staging/do # Cloud Provider
        |-- ./staging/do/nyc1 # Cloud Provider Region
        |   |-- ./staging/do/nyc1/region.hcl # Cloud Provider Region variables
        |   |-- ./staging/do/nyc1/computing # Resource class
        |   |   |-- ./staging/do/nyc1/computing/vms # Resource type
        |   |   `-- ./staging/do/nyc1/computing/k8s # Resource type
        |   |       |-- ./staging/do/nyc1/computing/k8s/cocre-sup # Application name
        |   |       |   `-- ./staging/do/nyc1/computing/k8s/cocre-sup/terragrunt.hcl # Application configurations
        |   |       `-- ./staging/do/nyc1/computing/k8s/cocre # Application name
        |   |           `-- ./staging/do/nyc1/computing/k8s/cocre/terragrunt.hcl # Application configurations
        |   |-- ./staging/do/nyc1/networking # Resource class
        |   |   `-- ./staging/do/nyc1/networking/vpc # Resource type
        |   |       `-- ./staging/do/nyc1/networking/vpc/default # Application name
        |   |           `-- ./staging/do/nyc1/networking/vpc/default/terragrunt.hcl # Application configurations
        |   `-- ./staging/do/nyc1/_common # Common resources within this regions
        |       `-- ./staging/do/nyc1/_common/tags # Resource type
        |           `-- ./staging/do/nyc1/_common/tags/terragrunt.hcl # Resource definition
        |-- ./staging/do/_common # Common resources within this cloud provider
        |   |-- ./staging/do/_common/tags # Resource type
        |   |   `-- ./staging/do/_common/tags/terragrunt.hcl # Resource definition
        `-- ./staging/do/sfo2 # Cloud provider region
`-- ./develop # Environment
    |-- ./develop/gcp # Cloud Provider
    |   |-- ./develop/gcp/_common # Common resources this CP
    |   `-- ./develop/gcp/us-west-1 # Cloud Provider Region
    ...
    ......
```