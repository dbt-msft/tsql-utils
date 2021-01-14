{% macro sqlserver__current_timestamp() %}
    getdate()
{% endmacro %}

{% macro synapse__current_timestamp() %}
    {% do return( tsql_utils.sqlserver__current_timestamp()) %}
{% endmacro %}

{% macro sqlserver__current_timestamp_in_utc() %}
    getutcdate()
{% endmacro %}

{% macro synapse__current_timestamp_in_utc() %}
    {% do return( tsql_utils.sqlserver__current_timestamp_in_utc()) %}
{% endmacro %}
