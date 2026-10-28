variable "stage" {
  type = string

  validation {
    condition     = contains(["Speculative", "Prospective", "Operative"], var.stage)
    error_message = "Stage must be one of: Speculative, Prospective, Operative."
  }
}

variable "organization_name" {
  type = string
  default = "amiasea"
}

variable "location" {
  type = string
  default = "centralus"
}

variable "subscription_id" {
  type = string
}