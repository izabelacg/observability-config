#################################
# PROVIDERS
#################################

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

#################################
# RESOURCES - DASHBOARDS
#################################

resource "datadog_dashboard" "concourse" {
  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = "Concourse Dashboard"

  widget {

    timeseries_definition {
      show_legend = false
      title       = "Worker Containers"

      marker {
        display_type = "error dashed"
        label        = "\u00a0max containers\u00a0"
        value        = "y = 256"
      }

      request {
        display_type = "line"
        q            = "avg:${var.concourse_datadog_prefix}.worker_containers{*} by {worker}"

        style {
          line_type  = "solid"
          line_width = "normal"
          palette    = "dog_classic"
        }
      }

      yaxis {
        include_zero = false
        max          = "256"
      }
    }
  }
}