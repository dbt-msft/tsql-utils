{% macro sqlserver__convert_timezone(column, target_tz, source_tz) -%}
    CAST({{ column }} as {{ dbt_utils.type_timestamp() }}) AT TIME ZONE '{{ source_tz }}' AT TIME ZONE '{{ target_tz }}'
{%- endmacro -%}
