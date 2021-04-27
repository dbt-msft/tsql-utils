{% macro sqlserver__log_natural(x) %}

    log({{ x }})

{%- endmacro -%}


{% macro synapse__log_natural(x) -%}
    {% do return( dbt_expectations.sqlserver__log_natural(x)) %}
{%- endmacro -%}