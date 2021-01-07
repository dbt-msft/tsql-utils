{% macro sqlserver__test_unique_where(model) %}
  {% set column_name = kwargs.get('column_name', kwargs.get('arg')) %}
  {% set where = kwargs.get('where', kwargs.get('arg')) %}
  {# override generic default #}
  {# TSQL has no bool type #}
  {% if where == '_deleted = false' %}
      {% set where = '_deleted = 0' %}
  {% endif %}

  {{ return(dbt_utils.default__test_unique_where(model, column_name=column_name, where=where)) }}

{% endmacro %}
