terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.18.0"
    }
  }
}

locals {
  policy_topics = [
    "hacktoberfest",
    "kubernetes",
    "kubernetes-security",
    "kubewarden-policy",
    "policy-as-code",
    "webassembly",
  ]
}

variable "has_downloads" {
  default = true
}

variable "has_issues" {
  default = true
}

variable "has_projects" {
  default = false
}

variable "has_wiki" {
  default = true
}

variable "name" {
}

variable "description" {
  default = ""
}

variable "extra_topics" {
  default = []
}

variable template {
  default = []
}

resource "github_repository" "main" {
  name                 = var.name
  topics               = concat( local.policy_topics, var.extra_topics)
  description          = var.description
  has_downloads        = var.has_downloads
  has_issues           = var.has_issues
  has_projects         = var.has_projects
  has_wiki             = var.has_wiki
  vulnerability_alerts = true

  dynamic "template" {
    for_each = var.template
    content {
      owner      = template.value["owner"]
      repository = template.value["repository"]
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
