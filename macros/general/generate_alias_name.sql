{% macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {%- set naming = model_naming_parts(node) -%}

    {%- if naming is not none -%}
        {{ naming['alias'] }}
    {%- elif custom_alias_name is not none -%}
        {{ custom_alias_name | trim }}
    {%- elif node.version -%}
        {{ node.name ~ "_v" ~ (node.version | string | replace(".", "_")) }}
    {%- else -%}
        {{ node.name }}
    {%- endif -%}

{%- endmacro %}