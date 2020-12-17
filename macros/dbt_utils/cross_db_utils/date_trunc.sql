{% macro sqlserver__date_trunc(datepart, date) %}
    datepart({{datepart}}, {{date}}) 
{% endmacro %}
