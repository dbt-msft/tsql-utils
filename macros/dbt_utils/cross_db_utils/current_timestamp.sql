{% macro sqlserver__current_timestamp() %}
    getdate()
{% endmacro %}

{% macro sqlserver__current_timestamp_in_utc() %}
    getutcdate()
{% endmacro %}
