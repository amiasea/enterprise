resource "github_repository" "tannin_solution_topology" {
  name        = "tannin"
  description = "Tannin Solution Topology"

  visibility = "public"

  template {
    owner                = "amiasea"
    repository           = var.solution_topology_template_repo_name
    include_all_branches = true
  }
}

resource "github_repository_custom_property" "tannin_solution_type_property" {
  repository     = github_repository.tannin_solution_topology.name
  property_name  = "type"
  property_type  = "single_select"
  property_value = ["topology"]
}

resource "github_repository_ruleset" "solution_topology" {
  name        = "Solution topology conformance"
  repository  = github_repository.tannin_solution_topology.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = [
        "refs/heads/development",
        "refs/heads/main"
      ]
      exclude = []
    }
  }

  rules {
    pull_request {
      required_approving_review_count = 0
    }

    required_status_checks {
      strict_required_status_checks_policy = true

      required_check {
        context = "Validate topology"
      }
    }
  }
}

data "github_release" "this" {
  owner       = "amiasea-enterprise-orchard"
  repository  = github_repository.tannin_solution_topology.name
  retrieve_by = "tag"
  release_tag = var.solution_topology_release_tag
}

data "github_release_asset" "topology" {
  owner = "amiasea-enterprise-orchard"
  repository = github_repository.tannin_solution_topology.name
  asset_id = local.topology_asset.id

  download_file_contents = true
}

locals {
  topology_asset = one([
    for asset in data.github_release.this.assets : asset
    if asset.name == "solution-topology.yml"
  ])
}