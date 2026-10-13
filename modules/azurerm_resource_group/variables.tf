variable "rg_var" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
  description = "Resource groups to create, keyed by a stable logical name."
  nullable    = false
}
