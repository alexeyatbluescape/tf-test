terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "1.15.3"
    }
  }
}

# Configure the env0 provider
provider "env0" {
  api_key         = var.env0_api_key
  api_secret      = var.env0_api_secret
  organization_id = var.env0_org_id
}


variable "env0_org_id" {
  type        = string
  description = "Env0 Org ID"
}

variable "env0_api_key" {
  type        = string
  description = "env0 API ID to manage org_id"
}

variable "env0_api_secret" {
  type        = string
  description = "env0 API secret to manage org_id"
}

variable "enable_plans" {
  type    = bool
  default = false
}

variable "repository" {
  type = string
}

variable "github_installation_id" {
  type = string
}

resource "env0_project" "example" {
  name        = "example"
  description = "Example project"
}

resource "env0_environment" "example_with_hcl_configuration" {
  name       = "environment with hcl"
  project_id = env0_project.example.id

  auto_deploy_by_custom_glob       = var.enable_plans ? "test/**" : null
  auto_deploy_on_path_changes_only = var.enable_plans ? true : null
  run_plan_on_pull_requests        = var.enable_plans

  without_template_settings {
    repository             = var.repository
    revision               = "master"
    path                   = "test"
    type                   = "terraform"
    terraform_version      = "1.5.6"
    github_installation_id = var.github_installation_id
  }
}