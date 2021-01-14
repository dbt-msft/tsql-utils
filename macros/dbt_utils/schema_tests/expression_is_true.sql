{% macro sqlserver__test_expression_is_true(model, condition) %}

{% set expression = kwargs.get('expression', kwargs.get('arg')) %}

with meet_condition as (

    select * from {{ model }} where {{ condition }}

),
validation_errors as (

    select
        *
    from meet_condition
    where not({{expression}})

)

select count(*)
from validation_errors

{% endmacro %}

{% macro synapse__test_expression_is_true(model, condition='1=1') %}
    {% set expression = kwargs.get('expression', kwargs.get('arg')) %}

    {% do return( tsql_utils.sqlserver__test_expression_is_true(model, condition='1=1')) %}
{% endmacro %}
