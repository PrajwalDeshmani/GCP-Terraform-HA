variable "project_id" {}
variable "primary_region" {}
variable "secondary_region" {}
variable "zones_primary" { type = list(string) }
variable "zones_secondary" { type = list(string) }
