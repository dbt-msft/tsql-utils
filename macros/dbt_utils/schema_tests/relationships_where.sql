{% macro sqlserver__test_relationships_where(model, to, field) %}

  {% set column_name = kwargs.get('column_name', kwargs.get('from')) %}
  {% set from_condition = kwargs.get('from_condition', "1=1") %}
  {% set to_condition = kwargs.get('to_condition', "1=1") %}
  {# override dbt-utils' integration tests args default see: #}
  {# https://github.com/fishtown-analytics/dbt-utils/blob/bbba960726667abc66b42624f0d36bbb62c37593/integration_tests/models/schema_tests/schema.yml#L67-L75 #}
  {# TSQL has non-ANSI not-equal sign #}
  {% if from_condition == 'id <> 4' %}
      {% set where = 'id != 4' %}
  {% endif %}

  {{ return(dbt_utils.default__test_relationships_where(model, to, field, column_name=column_name, from_condition=from_condition, to_condition=to_condition)) }}

{% endmacro %}
