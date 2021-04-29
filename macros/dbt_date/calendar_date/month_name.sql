{%- macro sqlserver__month_name(date, short) -%}
{%- set f = 'MMM' if short else 'MMMM' -%}
    format({{ date }}, '{{ f }}')
{%- endmacro %}

{% macro synapse__month_name(date, short) -%}
    {% do return( tsql_utils.sqlserver__month_name(date, short)) %}
{%- endmacro -%}