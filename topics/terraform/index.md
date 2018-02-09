---
created_by: Mitchell Hashimoto, HashiCorp
display_name: Terraform
github_url: https://github.com/hashicorp/terraform
logo: terraform.png
related: hashicorp, hashicorp-terraform, infrastructure, infrastructure-as-code, terraform-configurations, terraform-module, terraform-modules, terraform-providers
released: July 28, 2014
short_description: An infrastructure as code tool for building, changing, and versioning infrastructure safely and efficiently.
topic: terraform
url: https://www.terraform.io
wikipedia_url: https://en.wikipedia.org/wiki/Terraform_(software)
---
Terraform can manage existing and popular service providers as well as custom in-house solutions.

Configuration files describe to Terraform the components needed to run a single application or your entire datacenter.
It generates an execution plan describing what will happen to reach the desired state, and afterwards executes it to build the desired infrastructure.
As the configuration changes, Terraform is able to determine the changes and create incremental execution plans which can be applied.

The infrastructure Terraform can manage includes low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc.
