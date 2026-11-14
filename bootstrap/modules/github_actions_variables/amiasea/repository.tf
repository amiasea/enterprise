resource "github_actions_variable" "pomology_propagation_stack_id" {
  repository    = "enterprise-interim-control-plane"
  variable_name = "POMOLOGY_PROPAGATION_STACK_ID"
  value         = var.pomology_propagation_stack_id
}

resource "github_actions_variable" "pomology_pruning_stack_id" {
  repository    = "enterprise-interim-control-plane"
  variable_name = "POMOLOGY_PRUNING_STACK_ID"
  value         = var.pomology_pruning_stack_id
}