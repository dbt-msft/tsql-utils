{% macro sqlserver__get_test_week_of_year() -%}
    {# who knows what T-SQL uses?! #}
    {# see: https://github.com/calogica/dbt-date/issues/25 #}
    {{ return([49,49]) }}
{%- endmacro %}

{% macro synapse__get_test_week_of_year() -%}
     {{ return(sqlserver__get_test_week_of_year()) }}
{%- endmacro %}
