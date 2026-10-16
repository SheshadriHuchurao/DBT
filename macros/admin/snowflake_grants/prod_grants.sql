{% macro snowflake_prod_grants() %}
  {% set grants = {
      'prod': {
          'dbt_env_prod': ['all_schemas'],
          'indium_data_eng': ['data_store', 'dim', 'fact']
      }
  } %}
  {{ return(grants) }}
{% endmacro %}
