variable "environment"   { type = string }
variable "region"        { type = string }
variable "aws_profile"   { type = string }
variable "tags"          { type = map(string) }
variable "oidc_subjects" { type = list(string) }
variable "project_name"  { type = string }