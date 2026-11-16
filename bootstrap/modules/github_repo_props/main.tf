resource "github_organization_custom_properties" "institutive" {
  property_name = "institutive"
  value_type    = "true_false"
  required      = true
  description   = "Whether this repository is institutive"
  default_value = "false"
  values_editable_by = "org_actors"
}

resource "github_organization_custom_properties" "type" {
  provider = github.enterprise_orchard

  property_name     = "type"
  value_type        = "single_select"
  required          = true
  description       = "The type of repository"
  default_value     = "fruit"
  allowed_values    = ["topology", "fruit"]
  values_editable_by = "org_actors"
}