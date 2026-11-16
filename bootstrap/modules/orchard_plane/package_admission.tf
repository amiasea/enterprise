locals {
  package_admission = merge(
    {
      name = var.solution_topology.name
    },
    {
      for domain, components in var.solution_topology.domains :
      domain => [
        for component in components : {
          repository = component.repository
          release    = component.release
        }
      ]
    }
  )
}