# observability-config

How to use the [Terraform Datadog Provider](https://www.terraform.io/docs/providers/datadog/index.html) 
for configuring Concourse dashboards.

## Prerequisites

* [HashiCorp Terraform](https://www.terraform.io/downloads.html)

    ```
    brew install terraform
    ```

## Export existing Concourse Dashboards from Datadog

1. Follow the instructions [here](https://docs.datadoghq.com/dashboards/#copy-import-export) 
to export a JSON file containing the JSON of your dashboard.

## Deploy Datadog Dashboards for Concourse

1. Define the Datadog API and Application Key.
   ```shell
   export DATADOG_API_KEY=${DATADOG_API_KEY}
   export DATADOG_APP_KEY=${DATADOG_APP_KEY}
   ```

1. Run `make` to convert the JSON file you exported from Datadog into a proper `.tf.json` to be used later 
by Terraform:
   ```shell
   make concourse-dashboard-ci
   ```

1. Dry run the changes to the dashboards.
   ```shell
   terraform init
   terraform plan
   ```

1. Apply the changes to the dashboards.
   ```shell
   terraform apply
   ```
   
### Examples

Refer to the repo below to see another example on how to use Terraform Datadog Provider: 
https://github.com/hashicorp/observability-as-code