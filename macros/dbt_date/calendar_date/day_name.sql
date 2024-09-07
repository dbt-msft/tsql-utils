{%- macro fabric__day_name(date, short) -%}
{%- set f = 'ddd' if short else 'dddd' -%}
    format({{ date }}, '{{ f }}')
{%- endmacro %}
