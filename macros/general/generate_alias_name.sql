{% macro generate_alias_name(custom_alias_name=none, node=none) -%}
  {%- set parts = model_naming_parts(node) -%}
  {%- if custom_alias_name is not none -%}
    {{- custom_alias_name | trim -}}
  {%- elif parts is not none -%}
    {{- parts['alias'] -}}
  {%- else -%}
    {{- node.name -}}
  {%- endif -%}
{%- endmacro %}
