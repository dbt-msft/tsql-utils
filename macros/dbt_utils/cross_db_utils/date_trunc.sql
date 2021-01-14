{% macro sqlserver__date_trunc(datepart, date) %}
    CAST(DATEADD({{datepart}}, DATEDIFF({{datepart}}, 0, {{date}}), 0) AS DATE)
{% endmacro %}

{% macro synapse__date_trunc(datepart, date) %}
    {% do return( tsql_utils.sqlserver__date_trunc(datepart, date)) %}
{% endmacro %}
