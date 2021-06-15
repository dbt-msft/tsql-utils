{%- macro sqlserver__from_unixtimestamp(epochs, format) -%}
    
    {%- if format == "seconds" -%}
    {%- set scale = "S" -%}
    {%- elif format == "milliseconds" -%}
    {%- set scale = "ms" -%}
    {%- elif format == "microseconds" -%}
    {%- set scale = "mcs" -%}
    {%- else -%}
    {{ exceptions.raise_compiler_error(
        "value " ~ format ~ " for `format` for from_unixtimestamp is not supported."
        ) 
    }}
    {% endif -%}

    dateadd({{ scale }}, {{ epochs }}, '1970-01-01')

{%- endmacro %}

{% macro synapse__from_unixtimestamp(epochs, format) -%}
    {% do return( tsql_utils.sqlserver__from_unixtimestamp(epochs, format)) %}
{%- endmacro -%}