#################################
# VARIABLES
#################################

variable "datadog_api_key" {}
variable "datadog_app_key" {}

variable "deployment_tool" {
  type = string
  default = "helm"
  description = "Tool used to deploy Concourse (bosh / helm)"
}

