{%- macro sqlserver__day_name(date, short) -%}
{%- set f = 'ddd' if short else 'dddd' -%}
    format({{ date }}, '{{ f }}')
{%- endmacro %}

{% macro synapse__day_name(date, short) -%}
    {% do return( tsql_utils.sqlserver__day_name(date, short)) %}
{%- endmacro -%}