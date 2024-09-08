{% macro fabric__get_test_week_of_year() -%}
    {# who knows what T-SQL uses?! #}
    {# see: https://github.com/calogica/dbt-date/issues/25 #}
    {{ return([49,49]) }}
{%- endmacro %}

{% macro fabric__get_test_timestamps() -%}
    {{ return(['2021-06-07 07:35:20.000000',
                '2021-06-07 07:35:20.000000']) }}
{%- endmacro %}