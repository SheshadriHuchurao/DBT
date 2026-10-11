{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- if node is not none
          and node.resource_type == 'model'
          and node.name.startswith('stg_') -%}

        {%- set parts = node.name[4:].split('__', 1) -%}

        {%- if parts | length != 2 or not parts[0] or not parts[1] -%}
            {{ exceptions.raise_compiler_error(
                "Expected filename: stg_<schema>__<table>.sql. Got: "
                ~ node.name
            ) }}
        {%- endif -%}

        {{ parts[0] }}

    {%- elif custom_schema_name is not none -%}
        {{ custom_schema_name | trim }}

    {%- else -%}
        {{ target.schema }}

    {%- endif -%}

{%- endmacro %}