{% macro sqlserver__test_relationships_where(model) %}

  {% set from_condition = kwargs.get('from_condition', "1=1") %}
  {% set to_condition = kwargs.get('to_condition', "1=1") %}
  {# override generic default #}
  {# TSQL has non-ANSI not-equal sign #}
  {% if from_condition == 'id <> 4' %}
      {% set where = 'id != 4' %}
  {% endif %}

  {{ return(default__test_not_null_where(model)) }}

{% endmacro %}
