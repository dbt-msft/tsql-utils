{% macro sqlserver__get_url_host(field) -%}
{{ return('foobar') }}
{%- endmacro %}

{% macro synapse__get_url_host(model) %}
    {% do return(sqlserver__get_url_host(model)) %}
{% endmacro %}