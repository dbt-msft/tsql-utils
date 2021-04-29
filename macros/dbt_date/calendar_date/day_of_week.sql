
{%- macro sqlserver__day_of_week(date, isoweek) -%}

    {%- set dow = dbt_date.date_part('weekday', date) -%}

    {%- if isoweek -%}
    case
        -- Shift start of week from Sunday (1) to Monday (2)
        when {{ dow }} = 1 then 7
        else {{ dow }} - 1
    end
    {%- else -%}
    {{ dow }}
    {%- endif -%}

{%- endmacro %}

{% macro synapse__day_of_week(date, isoweek) -%}
    {% do return( tsql_utils.sqlserver__day_of_week(date, isoweek)) %}
{%- endmacro -%}