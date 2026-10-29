{% macro generate_schema_name(custom_schema_name=none, node=none) -%}
  {%- set parts = model_naming_parts(node) -%}
  {%- if custom_schema_name is not none -%}
    {{- custom_schema_name | trim -}}
  {%- elif parts is not none -%}
    {{- parts['schema'] -}}
  {%- else -%}
    {{- target.schema -}}
  {%- endif -%}
{%- endmacro %}
