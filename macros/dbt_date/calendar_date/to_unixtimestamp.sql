{%- macro sqlserver__to_unixtimestamp(timestamp) -%}
   DATEDIFF_BIG(ns, '1970-01-01 00:00:00', {{ timestamp }})
{%- endmacro %}
