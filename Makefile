DATADOG_DASHBOARD_HH_JSON="$(shell ls HushHouse*.json | head -1)"
DATADOG_DASHBOARD_CI_JSON="$(shell ls Concourse*.json | head -1)"

#TODO consolidate jq queries

concourse-dashboard-hh:
	jq '.resource.datadog_dashboard.concourse_hh = \
	(.widget = .widgets | .template_variable = .template_variables | \
	.widget |= map((. | .definition.request = .definition.requests | del(.definition.requests) | \
	del(.definition.tags_execution) | \
	del(.definition.request | select(. == null)) | \
	del(.definition.show_legend | select(. == false)) | \
	."\(.definition.type)_definition" = .definition ) | \
	del(."\(.definition.type)_definition".type, ."\(.definition.type)_definition".legend_size) // .) | \
	del(.widget[].definition, .widget[].id, .widgets, .template_variables, .id)) | \
	del(.title, .description, .layout_type, .is_read_only, .notify_list, .id, .widgets, .template_variables)' \
	$(DATADOG_DASHBOARD_HH_JSON) > dashboard-hh.tf.json

concourse-dashboard-ci:
	jq '.resource.datadog_dashboard.concourse_ci = \
	(.widget = .widgets | .template_variable = .template_variables | \
	if (.template_variable_presets) then (.template_variable_preset = .template_variable_presets) else . end | \
	if (.template_variable_preset) then (.template_variable_preset |= map(.template_variable = .template_variables)) else . end | \
	.widget |= map((. | .definition.request = .definition.requests | del(.definition.requests) | \
	.definition.widget = .definition.widgets | del(.definition.widgets) | \
	.definition.widget |= map(.definition.request = .definition.requests | del(.definition.requests) | \
	.definition.marker = .definition.markers | del(.definition.markers) | \
	del(.definition.marker | select(. == null)) | \
	."\(.definition.type)_definition" = .definition | \
	del(."\(.definition.type)_definition".type, ."\(.definition.type)_definition".legend_size) | del(.definition, .id)) | \
	del(.definition.tags_execution) | \
	del(.definition.request | select(. == null)) | \
	del(.definition.show_legend | select(. == false)) | \
	."\(.definition.type)_definition" = .definition ) | \
	del(."\(.definition.type)_definition".type, ."\(.definition.type)_definition".legend_size) // .) | \
	if (.template_variable_preset) then del(.template_variable_preset[] | select(.template_variable == [])) else . end | \
	if (.template_variable_preset) then del(.template_variable_preset[].template_variables) else . end | \
	if (.template_variable_presets) then del(.template_variable_presets) else . end | \
	del(.widget[].definition, .widget[].id, .widgets, .template_variables, .id)) | \
	if (.template_variable_presets) then del(.template_variable_presets) else . end | \
	del(.title, .description, .layout_type, .is_read_only, .notify_list, .id, .widgets, .template_variables)' \
	$(DATADOG_DASHBOARD_CI_JSON) > dashboard-ci.tf.json
