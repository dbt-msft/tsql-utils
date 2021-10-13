{%- macro sqlserver__week_start(date) -%}
-- Sunday as week start date
cast({{ dbt_utils.dateadd('day', -1, dbt_utils.date_trunc('week', dbt_utils.dateadd('day', 1, date))) }} as date)
{%- endmacro %}
