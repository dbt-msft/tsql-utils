{%- macro sqlserver__iso_week_start(date) -%}
    cast(dateadd(week, datediff(week, 0, dateadd(day, -1, {{date}})), 0) as date)
{%- endmacro %}

{% macro synapse__iso_week_start(date) -%}
    {% do return( tsql_utils.sqlserver__iso_week_start(date)) %}
{%- endmacro -%}