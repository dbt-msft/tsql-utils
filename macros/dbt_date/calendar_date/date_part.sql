{% macro sqlserver__date_part(datepart, date) -%}
    datepart({{ datepart }}, {{ date }})
{%- endmacro %}

{% macro synapse__date_part(datepart, date) -%}
    {% do return( tsql_utils.sqlserver__date_part(datepart, date)) %}
{%- endmacro -%}