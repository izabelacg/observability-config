#################################
# PROVIDERS
#################################

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

#################################
# MODULES
#################################

module "dashboards" {
  source = "./dashboards"

  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key

  dashboard_title = "Concourse Dashboard"

  concourse_datadog_prefix = "concourse_local"

  concourse_metrics_attribute = {
    environment = "ci"
  }

  concourse_web_tag_key = "kube_deployment"
  concourse_web_tag_value = "ci-web"
  concourse_worker_tag_key = "kube_stateful_set"
  concourse_worker_tag_value = "ci-worker"
}