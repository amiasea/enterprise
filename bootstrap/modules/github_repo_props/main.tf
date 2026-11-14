resource "github_organization_custom_properties" "institutive" {
  property_name = "institutive"
  value_type    = "true_false"
  required      = true
  description   = "Whether this repository is institutive"
  default_value = "false"
  values_editable_by = "org_actors"
}

# only set for cordons
resource "github_organization_custom_properties" "varieties" {
  provider = github.enterprise_orchard

  property_name = "varieties"
  value_type    = "string"
  required      = false
  description   = "Cordon variety set"
  default_value = null
  values_editable_by = "org_actors"
}

# only set for cordons
resource "github_organization_custom_properties" "cordon" {
  provider = github.enterprise_orchard

  property_name = "cordon"
  value_type    = "true_false"
  required      = true
  description   = "Whether this repository is an espalier cordon"
  default_value = "false"
  values_editable_by = "org_actors"
}

# set for cordons and leaves
resource "github_organization_custom_properties" "aspect_options" {
  provider = github.enterprise_orchard

  property_name = "aspect_options"
  value_type    = "string"
  required      = false
  description   = "Espalier aspect options set"
  default_value = null
  values_editable_by = "org_actors"
}

# set for cordons and leaves
resource "github_organization_custom_properties" "tier" {
  provider = github.enterprise_orchard

  property_name = "tier"
  value_type    = "string"
  required      = false
  description   = "Espalier tier"
  default_value = null
  values_editable_by = "org_actors"
}