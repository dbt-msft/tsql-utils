{% macro sqlserver__get_url_host(field) -%}
{{ return('foobar') }}
{%- endmacro %}

{% macro synapse__get_url_host(model) %}
    {% do return( tsql_utils.sqlserver__get_url_host(model)) %}
{% endmacro %}