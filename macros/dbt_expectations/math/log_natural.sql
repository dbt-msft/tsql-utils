{% macro sqlserver__log_natural(x) %}

    log({{ x }})

{%- endmacro -%}
