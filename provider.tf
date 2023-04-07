provider "aws" {
  region = var.region1
}

provider "aws" {
  region = var.region2
  alias = "west"
}