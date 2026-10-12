{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set naming = model_naming_parts(node) -%}

    {%- if naming is not none -%}
        {{ naming['schema'] }}
    {%- elif custom_schema_name is not none -%}
        {{ custom_schema_name | trim }}
    {%- else -%}
        {{ target.schema }}
    {%- endif -%}

{%- endmacro %}