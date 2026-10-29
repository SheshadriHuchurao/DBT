{% macro generate_database_name(custom_database_name=none, node=none) -%}
  {%- set parts = model_naming_parts(node) -%}
  {%- if custom_database_name is not none -%}
    {{- custom_database_name | trim -}}
  {%- elif parts is not none -%}
    {{- parts['database'] -}}
  {%- elif node.resource_type == 'seed' -%}
    {{- var('dbt_prod_database', 'PROD') -}}
  {%- else -%}
    {{- target.database -}}
  {%- endif -%}
{%- endmacro %}
