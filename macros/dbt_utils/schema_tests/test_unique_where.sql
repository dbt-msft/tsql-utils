{% macro sqlserver__test_unique_where(model) %}

  {% set where = kwargs.get('where', kwargs.get('arg')) %}
  {# override generic default #}
  {# TSQL has no bool type #}
  {% if where == '_deleted = false' %}
      {% set where = '_deleted = 0' %}
  {% endif %}

  {{ return(default__test_unique_where(model)) }}

{% endmacro %}
