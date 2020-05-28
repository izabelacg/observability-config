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

  template_variable {
    default = "*"
    name    = "environment"
    prefix  = "environment"
  }

  template_variable {
    default = "*"
    name    = "worker"
    prefix  = var.concourse_worker_tag_key
  }

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
        q            = "avg:${var.concourse_datadog_prefix}.worker_containers{$environment} by {worker}"

        style {
          line_type  = local.request.style.line_type
          line_width = local.request.style.line_width
          palette    = local.request.style.palette
        }
      }

      yaxis {
        include_zero = false
        max          = "256"
      }
    }
  }
}

locals {
  request = {
    style = {
      line_type  = "solid"
      line_width = "normal"
      palette    = "dog_classic"
    }
  }
}