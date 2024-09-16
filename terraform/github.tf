terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.3.0"
    }
  }
}

provider "github" {
  token = var.token
  owner = "kubewarden"
  alias = "kubewarden"
}
