{% macro model_naming_parts(node) %}

    {% set database_map = {
        'stg': 'raw',
        'int': 'prod',
        'dim': 'prod',
        'fact': 'prod',
        'data_store': 'prod'
    } %}

    {% if node is none %}
        {{ return(none) }}
    {% endif %}

    {% if node.resource_type != 'model'
          or node.package_name != 'my_new_project' %}
        {{ return(none) }}
    {% endif %}

    {% set parts = node.name.split('__', 1) %}
    {% set prefix = node.name.split('_', 1)[0] %}

    {% if prefix not in database_map %}
        {{ return(none) }}
    {% endif %}

    {% set header = parts[0].split('_', 1) %}

    {% if parts | length != 2
          or header | length != 2 %}
        {{ exceptions.raise_compiler_error(
            "Expected <prefix>_<schema>__<object>: " ~ node.name
        ) }}
    {% endif %}

    {% if not header[1] or not parts[1] %}
        {{ exceptions.raise_compiler_error(
            "Schema and object name cannot be empty: " ~ node.name
        ) }}
    {% endif %}

    {{ return({
        'database': database_map[prefix],
        'schema': header[1],
        'alias': parts[1]
    }) }}

{% endmacro %}