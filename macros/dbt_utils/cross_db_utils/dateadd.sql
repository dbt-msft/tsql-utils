{% macro sqlserver__dateadd(datepart, interval, from_date_or_timestamp) %}

    dateadd(
        {{ datepart }},
        {{ interval }},
        cast({{ from_date_or_timestamp }} as datetime)
        )

{% endmacro %}

{% macro synapse__dateadd(datepart, interval, from_date_or_timestamp) %}
    {% do return( tsql_utils.sqlserver__dateadd(datepart, interval, from_date_or_timestamp)) %}
{% endmacro %}