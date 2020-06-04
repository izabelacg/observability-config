#################################
# VARIABLES
#################################

variable "datadog_api_key" {}
variable "datadog_app_key" {}

variable "dashboard_title" {}

variable "concourse_datadog_prefix" {}

variable "filter_by" {
  type = map(string)
}

variable "deployment_tool" {
  type        = string
  description = "Tool used to deploy Concourse (bosh / helm)"
}