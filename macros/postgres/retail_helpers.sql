{% macro money(expression) -%} round({{ expression }}, 2)::number(18,2) {%- endmacro %}
{% macro surrogate_key(columns) -%}
 md5(concat_ws('|', {% for column in columns %}coalesce(cast({{ column }} as varchar), '__NULL__'){% if not loop.last %}, {% endif %}{% endfor %}))
{%- endmacro %}
{% macro cents_to_currency(column) -%} ({{ column }} / 100.0)::number(18,2) {%- endmacro %}
