#####################################################
# DASHBOARDS - SYSTEM STATS - HELM
#####################################################

resource "datadog_dashboard" "concourse_systemstats_for_all" {
  count        = 0
  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = "${var.dashboard_title} - System Stats_for_all"

  template_variable {
    default = local.environment_label_value
    name    = "environment"
    prefix  = local.environment_label_key
  }
  template_variable {
    default = local.web_label_value
    name    = "web"
    prefix  = local.web_label_key
  }
  template_variable {
    default = local.worker_label_value
    name    = "worker"
    prefix  = local.worker_label_key
  }

  widget {

    group_definition {
      layout_type = "ordered"
      title       = "System Stats"

      //      widget {
      //
      //        timeseries_definition {
      //          show_legend = false
      //          title       = "Web CPU Usage"
      //
      //          request {
      //            display_type = "line"
      //            q            = "avg:docker.cpu.user{$web} by {pod_name}"
      //
      //            style {
      //              line_type  = "solid"
      //              line_width = "normal"
      //              palette    = "cool"
      //            }
      //          }
      //          request {
      //            display_type = "line"
      //            q            = "avg:docker.cpu.system{$web} by {pod_name}"
      //
      //            style {
      //              line_type  = "solid"
      //              line_width = "normal"
      //              palette    = "warm"
      //            }
      //          }
      //
      //          yaxis {
      //            include_zero = true
      //            max          = "auto"
      //            min          = "auto"
      //            scale        = "linear"
      //          }
      //        }
      //      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Web Memory Usage"

          request {
            display_type = "line"
            q            = local.web_memory_usage[0]["request_query"]

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }
          request {
            display_type = "line"
            q            = local.web_memory_usage[1]["request_query"]

            metadata {
              alias_name = "swap"
              expression = local.web_memory_usage[1]["metadata_expression"]
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "warm"
            }
          }
          request {
            display_type = "line"
            q            = local.web_memory_usage[2]["request_query"]

            metadata {
              alias_name = "total"
              expression = local.web_memory_usage[2]["metadata_expression"]
            }

            style {
              line_type  = "dotted"
              line_width = "normal"
              palette    = "warm"
            }
          }

          yaxis {
            include_zero = true
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Worker CPU Usage"

          request {
            display_type = "line"
            q            = local.worker_cpu_usage[0]["request_query"]

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }
          request {
            display_type = "line"
            q            = local.worker_cpu_usage[1]["request_query"]

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "warm"
            }
          }

          yaxis {
            include_zero = true
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }
      }
      //      widget {
      //
      //        timeseries_definition {
      //          show_legend = false
      //          title       = "Worker Memory Usage"
      //
      //          request {
      //            display_type = "line"
      //            q            = "avg:docker.mem.rss{$worker} by {pod_name}"
      //
      //            style {
      //              line_type  = "solid"
      //              line_width = "normal"
      //              palette    = "cool"
      //            }
      //          }
      //          request {
      //            display_type = "line"
      //            q            = "avg:docker.mem.limit{$worker} by {pod_name}"
      //
      //            metadata {
      //              alias_name = "total"
      //              expression = "avg:docker.mem.limit{$worker} by {pod_name}"
      //            }
      //
      //            style {
      //              line_type  = "dotted"
      //              line_width = "normal"
      //              palette    = "warm"
      //            }
      //          }
      //
      //          yaxis {
      //            include_zero = true
      //            max          = "auto"
      //            min          = "auto"
      //            scale        = "linear"
      //          }
      //        }
      //      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Web Network In"

          request {
            display_type = "line"
            q            = local.web_network_in[0]["request_query"]

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = true
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Web Network Out"

          request {
            display_type = "line"
            q            = local.web_network_out[0]["request_query"]

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = true
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Load"

          marker {
            display_type = "error dashed"
            value        = "y > 100"
          }

          request {
            display_type = "line"
            q            = local.system_load

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = true
            max          = "auto"
            min          = "auto"
            scale        = "linear"
          }
        }
      }
    }
  }
}

locals {

  web_memory_usage_bosh = [
    {
      request_query       = "avg:system.mem.used{$web,$environment} by {host}",
      metadata_expression = ""
    },
    {
      request_query       = "avg:system.swap.used{$web,$environment} by {host}",
      metadata_expression = "avg:system.swap.used{$web,$environment} by {host}"
    },
    {
      request_query       = "avg:system.mem.total{$web,$environment}",
      metadata_expression = "avg:system.mem.total{$web,$environment}"
    }
  ]

  web_memory_usage_helm = [
    {
      request_query       = "avg:docker.mem.rss{$web} by {pod_name}",
      metadata_expression = ""
    },
    {
      request_query       = "avg:docker.mem.swap{$web} by {pod_name}",
      metadata_expression = "avg:docker.mem.swap{$web} by {pod_name}"
    },
    {
      request_query       = "avg:docker.mem.limit{$web} by {pod_name}",
      metadata_expression = "avg:docker.mem.limit{$web} by {pod_name}"
    }
  ]

  web_memory_usage = var.deployment_tool == "bosh" ? local.web_memory_usage_bosh : local.web_memory_usage_helm

  worker_cpu_usage_bosh = [
    { request_query = "avg:system.cpu.user{$environment,$worker} by {bosh_id}" },
    { request_query = "avg:system.cpu.system{$environment,$worker} by {bosh_id}" }
  ]

  worker_cpu_usage_helm = [
    { request_query = "avg:docker.cpu.user{$worker} by {pod_name}" },
    { request_query = "avg:docker.cpu.system{$worker} by {pod_name}" }
  ]

  worker_cpu_usage = var.deployment_tool == "bosh" ? local.worker_cpu_usage_bosh : local.worker_cpu_usage_helm

  worker_memory_usage_bosh = [
    {
      request_query       = "avg:system.mem.used{$environment,$worker} by {bosh_id}",
      metadata_expression = ""
    },
    {
      request_query       = "avg:system.mem.total{$environment,$worker} by {bosh_id}"
      metadata_expression = "avg:system.mem.total{$environment,$worker} by {bosh_id}"
    }
  ]

  worker_memory_usage_helm = [
    {
      request_query       = "avg:docker.mem.rss{$worker} by {pod_name}",
      metadata_expression = ""
    },
    {
      request_query       = "avg:docker.mem.limit{$worker} by {pod_name}"
      metadata_expression = "avg:docker.mem.limit{$worker} by {pod_name}"
    }
  ]

  worker_memory_usage = var.deployment_tool == "bosh" ? local.worker_memory_usage_bosh : local.worker_memory_usage_helm


  web_network_in_bosh = [{ request_query = "avg:system.net.bytes_rcvd{$environment} by {bosh_name}" }]
  web_network_in_helm = [{ request_query = "avg:docker.net.bytes_rcvd{$web} by {pod_name}" }]
  web_network_in      = var.deployment_tool == "bosh" ? local.web_network_in_bosh : local.web_network_in_helm

  web_network_out_bosh = [{ request_query = "avg:system.net.bytes_rcvd{$environment} by {bosh_name}" }]
  web_network_out_helm = [{ request_query = "avg:docker.net.bytes_sent{$web} by {pod_name}" }]
  web_network_out      = var.deployment_tool == "bosh" ? local.web_network_out_bosh : local.web_network_out_helm

  system_load = "avg:system.load.1{goog-gke-node} by {host}"
}

// TODO
// 2 graphs not equivalent (Web CPU Usage / Worker Memory Usage)
// 3 graphs in bosh that are not in helm (DB related)