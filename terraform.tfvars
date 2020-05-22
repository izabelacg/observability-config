datadog_api_key = ""

datadog_app_key = ""

//TODO Use terraform workspaces instead? production / development / UAT
environment_name = "development"

// Prefix for all metrics to easily find them in Datadog [$CONCOURSE_DATADOG_PREFIX]
concourse_datadog_prefix = "concourse_local"

// A key-value attribute to attach to emitted metrics. [$CONCOURSE_METRICS_ATTRIBUTE]
concourse_metrics_attribute = {
  environment = "ci"
}
