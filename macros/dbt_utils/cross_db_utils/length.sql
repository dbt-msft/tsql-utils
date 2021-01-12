{% macro sqlserver__length(expression) %}

    len( {{ expression }} )

{%- endmacro -%}

{% macro synapse__length(expression) %}
    {% do return(sqlserver__length(expression)) %}
{%- endmacro -%}