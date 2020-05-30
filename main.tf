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

module "ci_dashboard" {
  source = "./dashboards"

  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key

  dashboard_title = "Concourse Dashboard - CI"

  deployment_tool = "helm"

  concourse_datadog_prefix = "concourse.ci"

  concourse_metrics_attribute = {
    environment = "ci"
  }

  concourse_web_tag_key = "kube_deployment"
  concourse_web_tag_value = "ci-web"
  concourse_worker_tag_key = "kube_stateful_set"
  concourse_worker_tag_value = "ci-worker"
}

module "hush_house_dashboard" {
  source = "./dashboards"

  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key

  dashboard_title = "Concourse Dashboard - Hush House"

  deployment_tool = "helm"

  concourse_datadog_prefix = "concourse.ci"

  concourse_metrics_attribute = {
    environment = "hush-house"
  }

  concourse_web_tag_key = "kube_deployment"
  concourse_web_tag_value = "hush-house-web"
  concourse_worker_tag_key = "kube_stateful_set"
  concourse_worker_tag_value = "workers-worker"
}