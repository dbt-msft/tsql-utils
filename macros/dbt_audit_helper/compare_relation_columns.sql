{% macro sqlserver__get_columns_in_relation_sql(relation) %}
  SELECT
            column_name,
            data_type,
            character_maximum_length,
            numeric_precision,
            numeric_scale
        FROM
            (select
                ordinal_position,
                column_name,
                data_type,
                character_maximum_length,
                numeric_precision,
                numeric_scale
            from INFORMATION_SCHEMA.COLUMNS
            where table_name = '{{ relation.identifier }}'
              and table_schema = '{{ relation.schema }}'
            UNION ALL
            select
                ordinal_position,
                column_name collate database_default,
                data_type collate database_default,
                character_maximum_length,
                numeric_precision,
                numeric_scale
            from tempdb.INFORMATION_SCHEMA.COLUMNS
            where table_name like '{{ relation.identifier }}%') cols
        {# order by ordinal_position #}
{% endmacro %}

{% macro synapse__get_columns_in_relation_sql(relation) -%}
    {% do return( tsql_utils.sqlserver__get_columns_in_relation_sql(relation)) %}
{%- endmacro %}