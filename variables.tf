#################################
# VARIABLES
#################################

variable "datadog_api_key" {}
variable "datadog_app_key" {}

// production / staging / UAT
variable "environment_name" {
  type = string
  default = "development"
}

//TODO use deployment_target instead? k8s / vms
// helm / bosh / docker
variable "deployment_tool" {
  type = string
  default = "docker"
}

variable "concourse_datadog_prefix" {
  type = string
  default = "concourse"
}

variable "concourse_metrics_attribute" {
  type = map(string)
}
