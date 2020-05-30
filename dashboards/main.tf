#################################
# RESOURCES - DASHBOARDS
#################################

resource "datadog_dashboard" "concourse" {
  is_read_only = false
  layout_type  = "ordered"
  notify_list  = []
  title        = var.dashboard_title

  template_variable {
    default = lookup(var.concourse_metrics_attribute, "environment")
    name    = "environment"
    prefix  = "environment"
  }
  template_variable {
    default = var.concourse_web_tag_value
    name    = "web"
    prefix  = var.concourse_web_tag_key
  }
  template_variable {
    default = var.concourse_worker_tag_value
    name    = "worker"
    prefix  = var.concourse_worker_tag_key
  }

  widget {

    group_definition {
      layout_type = "ordered"
      title       = "Web Nodes"

      widget {

        heatmap_definition {
          title = "Scheduling By Job"

          request {
            q = "avg:${var.concourse_datadog_prefix}.scheduling_job_duration_ms{$environment} by {job,job_id}"

            style {
              palette = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
            max          = "100000"
            min          = "1"
            scale        = "log"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Total Time Scheduling Jobs"

          request {
            display_type = "line"
            q            = "sum:${var.concourse_datadog_prefix}.scheduling_job_duration_ms{$environment}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Garbage Collection"

          marker {
            display_type = "warning dashed"
            value        = "y > 10000"
          }
          marker {
            display_type = "error dashed"
            value        = "y > 60000"
          }

          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.gc_build_collector_duration_ms{$environment}"

            metadata {
              alias_name = "builds"
              expression = "max:${var.concourse_datadog_prefix}.gc_build_collector_duration_ms{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.gc_volume_collector_duration_ms{$environment}"

            metadata {
              alias_name = "volumes"
              expression = "max:${var.concourse_datadog_prefix}.gc_volume_collector_duration_ms{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.gc_worker_collector_duration_ms{$environment}"

            metadata {
              alias_name = "workers"
              expression = "max:${var.concourse_datadog_prefix}.gc_worker_collector_duration_ms{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.gc_artifact_collector_duration_ms{$environment}"

            metadata {
              alias_name = "artifacts"
              expression = "max:${var.concourse_datadog_prefix}.gc_artifact_collector_duration_ms{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.gc_container_collector_duration_ms{$environment}"

            metadata {
              alias_name = "containers"
              expression = "max:${var.concourse_datadog_prefix}.gc_container_collector_duration_ms{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.gc_resource_cache_collector_duration_ms{$environment}"

            metadata {
              alias_name = "resource caches"
              expression = "max:${var.concourse_datadog_prefix}.gc_resource_cache_collector_duration_ms{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.gc_resource_config_collector_duration_ms{$environment}"

            metadata {
              alias_name = "resource configs"
              expression = "max:${var.concourse_datadog_prefix}.gc_resource_config_collector_duration_ms{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.gc_resource_cache_use_collector_duration_ms{$environment}"

            metadata {
              alias_name = "resource cache uses"
              expression = "max:${var.concourse_datadog_prefix}.gc_resource_cache_use_collector_duration_ms{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.gc_resource_config_check_session_collector_duration_ms{$environment}"

            metadata {
              alias_name = "rccs"
              expression = "max:${var.concourse_datadog_prefix}.gc_resource_config_check_session_collector_duration_ms{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
            scale        = "log"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Build Durations"

          marker {
            display_type = "error dashed"
            value        = "y > 60000"
          }

          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.build_finished{$environment} by {job}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
            scale        = "sqrt"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Builds Created"

          marker {
            display_type = "ok dashed"
            value        = "y > 50"
          }

          request {
            display_type = "line"
            q            = "derivative(max:${var.concourse_datadog_prefix}.build_started{$environment}), robust_trend(derivative(max:${var.concourse_datadog_prefix}.build_started{$environment}))"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
            min          = "0"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Build Status"

          marker {
            display_type = "ok dashed"
            value        = "y > 50"
          }

          request {
            display_type = "line"
            q            = "sum:${var.concourse_datadog_prefix}.build_finished{$environment} by {build_status}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
            min          = "0"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "DB Connections"

          marker {
            display_type = "error dashed"
            value        = "y > 50"
          }

          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.database_connections{$environment,connectionname:backend} by {host}, robust_trend(avg:${var.concourse_datadog_prefix}.database_connections{$environment,connectionname:backend})"

            style {
              line_type  = "solid"
              line_width = "thin"
              palette    = "warm"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.database_connections{$environment,connectionname:api} by {host}"

            style {
              line_type  = "solid"
              line_width = "thin"
              palette    = "cool"
            }
          }
          request {
            display_type = "line"
            q            = "max:${var.concourse_datadog_prefix}.database_connections{$environment,connectionname:gc} by {host}"

            style {
              line_type  = "solid"
              line_width = "thin"
              palette    = "grey"
            }
          }

          yaxis {
            include_zero = false
            max          = "64"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "DB Queries"

          request {
            display_type = "bars"
            q            = "avg:${var.concourse_datadog_prefix}.database_queries{$environment} by {host}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "HTTP Response Time"

          marker {
            display_type = "ok dashed"
            value        = "0 < y < 100"
          }
          marker {
            display_type = "warning dashed"
            value        = "y > 1000"
          }
          marker {
            display_type = "error dashed"
            value        = "y > 10000"
          }

          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.http_response_time{$environment} by {route}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
            scale        = "log"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Locks Held"

          request {
            display_type = "bars"
            q            = "avg:${var.concourse_datadog_prefix}.lock_held{$environment} by {type}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "dog_classic"
            }
          }

          yaxis {
            include_zero = false
            max          = "10"
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Web Goroutines"

          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.goroutines{$environment} by {host}"

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
  widget {

    group_definition {
      layout_type = "ordered"
      title       = "Worker Nodes"

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
      widget {

        heatmap_definition {
          title = "Worker Volumes"

          request {
            q = "avg:${var.concourse_datadog_prefix}.worker_volumes{$environment} by {worker}"

            style {
              palette = "grey"
            }
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Worker States"

          request {
            display_type = "area"
            q            = "avg:${var.concourse_datadog_prefix}.worker_state{$environment} by {state}"

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "grey"
            }
          }
        }
      }
    }
  }
  widget {

    group_definition {
      layout_type = "ordered"
      title       = "Containers and Volumes"

      widget {

        timeseries_definition {
          show_legend = false
          title       = "Containers to be GC'd"

          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.created_containers_to_be_garbage_collected{$environment}"

            metadata {
              alias_name = "created"
              expression = "avg:${var.concourse_datadog_prefix}.created_containers_to_be_garbage_collected{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }
          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.failed_containers_to_be_garbage_collected{$environment}"

            metadata {
              alias_name = "failed"
              expression = "avg:${var.concourse_datadog_prefix}.failed_containers_to_be_garbage_collected{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "orange"
            }
          }
          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.creating_containers_to_be_garbage_collected{$environment}"

            metadata {
              alias_name = "creating"
              expression = "avg:${var.concourse_datadog_prefix}.creating_containers_to_be_garbage_collected{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "grey"
            }
          }
          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.destroying_containers_to_be_garbage_collected{$environment}"

            metadata {
              alias_name = "destroying"
              expression = "avg:${var.concourse_datadog_prefix}.destroying_containers_to_be_garbage_collected{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "purple"
            }
          }
        }
      }
      widget {

        timeseries_definition {
          show_legend = false
          title       = "Volumes to be GC'd"

          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.created_volumes_to_be_garbage_collected{$environment}"

            metadata {
              alias_name = "created"
              expression = "avg:${var.concourse_datadog_prefix}.created_volumes_to_be_garbage_collected{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "cool"
            }
          }
          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.failed_volumes_to_be_garbage_collected{$environment}"

            metadata {
              alias_name = "failed"
              expression = "avg:${var.concourse_datadog_prefix}.failed_volumes_to_be_garbage_collected{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "orange"
            }
          }
          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.orphaned_volumes_to_be_garbage_collected{$environment}"

            metadata {
              alias_name = "orphaned"
              expression = "avg:${var.concourse_datadog_prefix}.orphaned_volumes_to_be_garbage_collected{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "grey"
            }
          }
          request {
            display_type = "line"
            q            = "avg:${var.concourse_datadog_prefix}.destroying_volumes_to_be_garbage_collected{$environment}"

            metadata {
              alias_name = "destroying"
              expression = "avg.destroying_volumes_to_be_garbage_collected{$environment}"
            }

            style {
              line_type  = "solid"
              line_width = "normal"
              palette    = "purple"
            }
          }
        }
      }
    }
  }

}
