{%- macro sqlserver__get_select(model, expression, row_condition, group_by) %}
    select
        {% for g in group_by -%}
            {{ g }} as col_{{ loop.index }},
        {% endfor -%}
        {{ expression }} as expression
    from
        {{ model }}
    {%- if row_condition %}
    where
        {{ row_condition }}
    {% endif %}
    group by
        {% for g in group_by -%}
            {{ g }}{% if not loop.last %}, {% endif %}
        {% endfor %}
{% endmacro -%}