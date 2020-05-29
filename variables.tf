#################################
# VARIABLES
#################################

variable "datadog_api_key" {}
variable "datadog_app_key" {}

//TODO use deployment_target instead? k8s / vms
// helm / bosh / docker
variable "deployment_tool" {
  type = string
  default = "helm"
  description = ""
}

