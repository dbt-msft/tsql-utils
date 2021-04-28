{%- macro sqlserver__week_of_year(date) -%}
cast({{ dbt_date.date_part('week', dbt_utils.dateadd('day',-1,date)) }} as {{ dbt_utils.type_int() }})
{%- endmacro %}

{% macro synapse__week_of_year(date) -%}
    {% do return( tsql_utils.sqlserver__week_of_year(date)) %}
{%- endmacro -%}