{% macro sqlserver__position(substring_text, string_text) %}

    CHARINDEX(
        {{ substring_text }},
        {{ string_text }}
    )
    
{%- endmacro -%}

{% macro synapse__position(substring_text, string_text) %}
    {% do return(sqlserver__position(substring_text, string_text)) %}
{%- endmacro -%}
