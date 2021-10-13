{% macro sqlserver__test_at_least_one(model, column_name) %}

select count(*)
from (
    select
        {# subquery aggregate columns need aliases #}
        {# thus: 'unique_values' #}
      count({{ column_name }}) as unique_values

    from {{ model }}

    having count({{ column_name }}) = 0

) validation_errors

{% endmacro %}
