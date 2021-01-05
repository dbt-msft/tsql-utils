{% macro sqlserver__concat(fields) -%}
    concat({{ fields|join(', ') }}, '')
{%- endmacro %}

{% macro synapse__concat(fields) -%}
    {% do return(sqlserver__concat(fields)) %}
{%- endmacro %}