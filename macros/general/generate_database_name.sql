{% macro generate_database_name(custom_database_name=none, node=none) -%}

    {%- set naming = model_naming_parts(node) -%}

    {%- if naming is not none -%}
        {{ naming['database'] }}
    {%- elif custom_database_name is not none -%}
        {{ custom_database_name | trim }}
    {%- else -%}
        {{ target.database }}
    {%- endif -%}

{%- endmacro %}