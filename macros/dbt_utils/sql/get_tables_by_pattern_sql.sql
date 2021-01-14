{% macro sqlserver__get_tables_by_pattern_sql(schema_pattern, table_pattern, exclude='', database=target.database) %}

        SELECT DISTINCT
            table_schema AS "table_schema",
            table_name AS "table_name"
        FROM {{database}}.information_schema.tables
        WHERE table_schema LIKE '{{ schema_pattern }}'
        AND table_name LIKE '{{ table_pattern }}'
        AND table_name NOT LIKE '{{ exclude }}'

{% endmacro %}

{#
    Imagine an adapter plugin, dbt-synapse, that inherits from dbt-sqlserver.
    For the time being, we need to explicitly reimplement sqlserver__ macros
    as synapse__ macros.
    
    TODO: We can make a small change to dbt-core (https://github.com/fishtown-analytics/dbt/issues/2923)
    that will make the inheritance of dispatched macros work just like the 
    inheritance of other adapter objects, and render the following code redundant.
#}
{% macro synapse__get_tables_by_pattern_sql(field) %}
    {% do return( tsql_utils.sqlserver__get_tables_by_pattern_sql(schema_pattern, table_pattern, exclude='', database=target.database)) %}
{% endmacro %}
