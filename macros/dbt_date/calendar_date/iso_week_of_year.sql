{%- macro sqlserver__iso_week_of_year(date) -%}
cast({{ dbt_date.date_part('iso_week', date) }} as {{ dbt_utils.type_int() }}) 
{%- endmacro %}

{% macro synapse__iso_week_of_year(date) -%}
    {% do return( tsql_utils.sqlserver__iso_week_of_year(date)) %}
{%- endmacro -%}