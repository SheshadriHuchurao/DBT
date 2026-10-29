{% macro model_naming_parts(node) %}
  {% set name = node.name | lower %}
  {% if node.resource_type != 'model' %}
    {{ return(none) }}
  {% endif %}
  {% if name.startswith('stg_') %}
    {% set parts = name[4:].split('__') %}
    {% if parts | length != 2 or not parts[0] or not parts[1] %}
      {{ exceptions.raise_compiler_error('Expected stg_<schema>__<object>: ' ~ name) }}
    {% endif %}
    {{ return({'database': 'RAW', 'schema': parts[0], 'alias': parts[1]}) }}
  {% endif %}
  {% set mappings = {'data_store_': 'DATA_STORE', 'int_': 'INTERMEDIATE', 'dim_': 'DIM', 'fact_': 'FACT'} %}
  {% for prefix, schema in mappings.items() %}
    {% if name.startswith(prefix) and name | length > prefix | length %}
      {{ return({'database': 'PROD', 'schema': schema, 'alias': name[prefix | length:]}) }}
    {% endif %}
  {% endfor %}
  {{ exceptions.raise_compiler_error('Unsupported model name: ' ~ name ~ '. Use stg_, int_, dim_, fact_, data_store_.') }}
{% endmacro %}
