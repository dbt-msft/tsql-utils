{% macro sqlserver__length(expression) %}

    len( {{ expression }} )

{%- endmacro -%}

{% macro synapse__length(expression) %}
    {% do return( tsql_utils.sqlserver__length(expression)) %}
{%- endmacro -%}