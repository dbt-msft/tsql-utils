{% macro sqlserver__position(substring_text, string_text) %}

    CHARINDEX(
        {{ substring_text }},
        {{ string_text }}
    )
    
{%- endmacro -%}

{% macro synapse__position(substring_text, string_text) %}
    {% do return(tsql_utils.sqlserver__position(substring_text, string_text)) %}
{%- endmacro -%}
