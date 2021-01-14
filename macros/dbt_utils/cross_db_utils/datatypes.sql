{%- macro sqlserver__type_string() -%}
    VARCHAR(900)
{%- endmacro -%}

-- TEMP UNTIL synapse is standalone adapter type
{% macro sqlserver__type_timestamp() %}
    {# Synapse does not support timestamp datatype see: #}
    {# https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-data-types#unsupported-data-types #}
    datetime
{% endmacro %}

{#
    Imagine an adapter plugin, dbt-synapse, that inherits from dbt-sqlserver.
    For the time being, we need to explicitly reimplement sqlserver__ macros
    as synapse__ macros.
    
    TODO: We can make a small change to dbt-core (https://github.com/fishtown-analytics/dbt/issues/2923)
    that will make the inheritance of dispatched macros work just like the 
    inheritance of other adapter objects, and render the following code redundant.
#}
{% macro synapse__type_string(field) %}
    {% do return( tsql_utils.sqlserver__type_string()) %}
{% endmacro %}


{% macro synapse__type_timestamp() %}
    {# Synapse does not support timestamp datatype see: #}
    {# https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-data-types#unsupported-data-types #}
    datetime
{% endmacro %}