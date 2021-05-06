terraform {
  required_version = ">= 0.12, < 0.13"
}

variable "names" {
  description = "A list of names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

variable "hero_thousand_faces" {
  description = "map"
  type        = map(string)
  default = {
    neo      = "hero"
    trinity  = "love interest"
    morpheus = "mentor"
  }
}

output "upper_names" {
  value = [for name in var.names : upper(name)]
}

output "short_upper_names" {
  value = [for name in var.names : upper(name) if length(name) < 5]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
  value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }
}

######
# Outputs:

# bios = [
#   "morpheus is the mentor",
#   "neo is the hero",
#   "trinity is the love interest",
# ]
# short_upper_names = [
#   "NEO",
# ]
# upper_names = [
#   "NEO",
#   "TRINITY",
#   "MORPHEUS",
# ]
# upper_roles = {
#   "MORPHEUS" = "MENTOR"
#   "NEO" = "HERO"
#   "TRINITY" = "LOVE INTEREST"
# }
