{% macro sql_string(value) -%}
'{{ (value | string).replace("'", "''") }}'
{%- endmacro %}

{% macro audit_relation(table_name) -%}
{{ adapter.quote(var('prod_database')) }}.{{ adapter.quote(var('audit_schema')) }}.{{ adapter.quote(table_name) }}
{%- endmacro %}

{% macro audit_enabled() %}
  {{ return(execute and invocation_args_dict.get('which') in ['run', 'build', 'test', 'seed', 'snapshot']) }}
{% endmacro %}

{% macro audit_initialize() %}
  {% if audit_enabled() %}
    {% do run_query('create schema if not exists ' ~ adapter.quote(var('prod_database')) ~ '.' ~ adapter.quote(var('audit_schema'))) %}
    {% set ddl %}
      create table if not exists {{ audit_relation('DBT_EVENTS') }} (
        invocation_id varchar, event_name varchar, node_id varchar,
        relation_name varchar, event_time timestamp_ltz, row_count number,
        command varchar, target_name varchar
      )
    {% endset %}
    {% do run_query(ddl) %}
    {% set ddl %}
      create table if not exists {{ audit_relation('DBT_NODE_RESULTS') }} (
        invocation_id varchar, node_id varchar, resource_type varchar,
        status varchar, execution_seconds float, message varchar,
        recorded_at timestamp_ltz
      )
    {% endset %}
    {% do run_query(ddl) %}
  {% endif %}
  {{ return('select 1') }}
{% endmacro %}

{% macro audit_run_start() %}
  {% if audit_enabled() %}
    insert into {{ audit_relation('DBT_EVENTS') }}
    values ({{ sql_string(invocation_id) }}, 'RUN_STARTED', null, null,
            current_timestamp(), null, {{ sql_string(invocation_args_dict.get('which')) }}, {{ sql_string(target.name) }})
  {% else %} select 1 {% endif %}
{% endmacro %}

{% macro audit_model_event(event_name) %}
  {% if audit_enabled() %}
    insert into {{ audit_relation('DBT_EVENTS') }}
    select {{ sql_string(invocation_id) }}, {{ sql_string(event_name) }},
           {{ sql_string(model.unique_id) }}, {{ sql_string(this) }}, current_timestamp(),
           {% if event_name == 'MODEL_MATERIALIZED' %} (select count(*) from {{ this }}) {% else %} null {% endif %},
           {{ sql_string(invocation_args_dict.get('which')) }}, {{ sql_string(target.name) }}
  {% else %} select 1 {% endif %}
{% endmacro %}

{% macro set_model_query_tag() %}
  alter session set query_tag = {{ sql_string('dbt|' ~ invocation_id ~ '|' ~ model.unique_id) }}
{% endmacro %}

{% macro clear_model_query_tag() %}
  alter session unset query_tag
{% endmacro %}

{% macro audit_run_end(results) %}
  {% if audit_enabled() %}
    {% set outcome = namespace(failed=false) %}
    {% for result in results %}
      {% if result.status | string in ['error', 'fail', 'runtime error', 'skipped'] %}
        {% set outcome.failed = true %}
      {% endif %}
      {% set statement %}
        insert into {{ audit_relation('DBT_NODE_RESULTS') }} values (
          {{ sql_string(invocation_id) }}, {{ sql_string(result.node.unique_id) }},
          {{ sql_string(result.node.resource_type) }}, {{ sql_string(result.status) }},
          {{ result.execution_time }}, {{ sql_string(result.message or '') }}, current_timestamp())
      {% endset %}
      {% do run_query(statement) %}
    {% endfor %}
    insert into {{ audit_relation('DBT_EVENTS') }} values (
      {{ sql_string(invocation_id) }}, '{{ "RUN_COMPLETED_WITH_FAILURES" if outcome.failed else "RUN_COMPLETED" }}',
      null, null, current_timestamp(), null,
      {{ sql_string(invocation_args_dict.get('which')) }}, {{ sql_string(target.name) }})
  {% else %} select 1 {% endif %}
{% endmacro %}
