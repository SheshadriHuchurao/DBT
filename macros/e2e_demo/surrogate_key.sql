{% macro surrogate_key(column) -%}
md5(coalesce(cast({{ column }} as varchar), '__NULL__'))
{%- endmacro %}
