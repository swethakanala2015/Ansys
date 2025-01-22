```hcl
module "vpc" {
  source                = "path/to/your/module"
  azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnet_cidr    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr   = ["10.0.3.0/24", "10.0.4.0/24"]
  db_subnet_cidr        = ["10.0.5.0/24", "10.0.6.0/24"]
  vpc_cidr              = "10.0.0.0/16"
  environment           = "dev"
  project_name          = "my-project"
  common_tags           = {
    "Owner" = "TeamA",
    "Environment" = "dev"
  }
  enable_nat            = true
  vpc_peering_enable    = false
}
```
