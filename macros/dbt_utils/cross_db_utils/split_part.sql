{% macro sqlserver__split_part(string_text, delimiter_text, part_number) %}

    split_part(
        {{ delimiter_text }},
        {{ string_text }},
        {{ part_number }}
        )

{% endmacro %}


{#
    Imagine an adapter plugin, dbt-synapse, that inherits from dbt-sqlserver.
    For the time being, we need to explicitly reimplement sqlserver__ macros
    as synapse__ macros.
    
    TODO: We can make a small change to dbt-core (https://github.com/fishtown-analytics/dbt/issues/2923)
    that will make the inheritance of dispatched macros work just like the 
    inheritance of other adapter objects, and render the following code redundant.
#}
{% macro synapse__split_part(string_text, delimiter_text, part_number) %}
    {% do return(sqlserver__split_part(string_text, delimiter_text, part_number)) %}
{% endmacro %}
