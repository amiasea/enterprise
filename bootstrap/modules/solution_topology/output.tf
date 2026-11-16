output "solution_topology" {
  description = "The released Solution Topology."

  type = object({
    name = string

    domains = map(list(object({
      repository = string
      release    = string
    })))
  })

  value = yamldecode(
    base64decode(data.github_release_asset.topology.file_contents)
  )
}

output "repositories" {
  description = "The solution topology repository."

  value = [{
    name          = data.github_repository.solution_topology.name
    repository_id = data.github_repository.solution_topology.repo_id
  }]
}

output "repository_ids" {
  description = "GitHub repository ID of the solution topology."

  value = [data.github_repository.solution_topology.repo_id]
}