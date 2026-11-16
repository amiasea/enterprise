variable "solution_topology" {
  type = object({
    name = string

    domains = map(list(object({
      repository = string
      release    = string
    })))
  })
}

variable "orchard_packages_repository" {
  description = "The shared CodeArtifact repository for orchard packages."

  type = object({
    name = string
    arn  = string
  })
}

variable "solution_topology_packages_repository" {
  description = "The CodeArtifact repository that orchard packages are admitted into."

  type = object({
    name = string
    arn  = string
  })
}