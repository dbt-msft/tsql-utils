{% macro sqlserver__type_string() %}
    VARCHAR(MAX)
{%- endmacro -%}

-- TEMP UNTIL synapse is standalone adapter type
{% macro sqlserver__type_timestamp() %}
    {# in TSQL timestamp is really datetime #}
    {# https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver15#DateandTimeDataTypes #}
    DATETIMEOFFSET
{% endmacro %}
