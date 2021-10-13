{% macro sqlserver__get_tables_by_pattern_sql(schema_pattern, table_pattern, exclude='', database=target.database) %}

        SELECT DISTINCT
            table_schema AS "table_schema",
            table_name AS "table_name"
        FROM {{database}}.information_schema.tables
        WHERE table_schema LIKE '{{ schema_pattern }}'
        AND table_name LIKE '{{ table_pattern }}'
        AND table_name NOT LIKE '{{ exclude }}'

{% endmacro %}
