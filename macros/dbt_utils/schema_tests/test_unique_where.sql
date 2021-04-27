{% macro sqlserver__test_unique_where(model) %}
  {% set column_name = kwargs.get('column_name', kwargs.get('arg')) %}
  {% set where = kwargs.get('where', kwargs.get('arg')) %}
  {# override dbt-utils' integration tests args default see: #}
  {# https://github.com/fishtown-analytics/dbt-utils/blob/bbba960726667abc66b42624f0d36bbb62c37593/integration_tests/models/schema_tests/schema.yml#L53-L65 #}
  {# TSQL has no bool type #}
  {% if where == '_deleted = false' %}
      {% set where = '_deleted = 0' %}
  {% endif %}

  {{ return(dbt_utils.default__test_unique_where(model, column_name=column_name, where=where)) }}

{% endmacro %}

{% macro synapse__test_unique_where(model) %}

  {% set column_name = kwargs.get('column_name', kwargs.get('arg')) %}
  {% set where = kwargs.get('where', kwargs.get('arg')) %}
  {# override dbt-utils' integration tests args default see: #}
  {# https://github.com/fishtown-analytics/dbt-utils/blob/bbba960726667abc66b42624f0d36bbb62c37593/integration_tests/models/schema_tests/schema.yml#L53-L65 #}
  {# TSQL has no bool type #}
  {% if where == '_deleted = false' %}
      {% set where = '_deleted = 0' %}
  {% endif %}

    {% do return( tsql_utils.sqlserver__test_unique_where(model)) %}
{% endmacro %}
