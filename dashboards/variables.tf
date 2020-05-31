#################################
# VARIABLES
#################################

variable "datadog_api_key" {}
variable "datadog_app_key" {}

variable "dashboard_title" {}

variable "concourse_datadog_prefix" {}

variable "concourse_metrics_attribute" {
  type = map(string)
}

variable "concourse_web_tag_key" {}
variable "concourse_web_tag_value" {}
variable "concourse_worker_tag_key" {}
variable "concourse_worker_tag_value" {}

variable "deployment_tool" {
  type        = string
  description = "Tool used to deploy Concourse (bosh / helm)"
}