{#
	For more information on how this XML trick works with splitting strings, see https://www.mssqltips.com/sqlservertip/1771/splitting-delimited-strings-using-xml-in-sql-server/
#}

{% macro sqlserver__split_part(string_text, delimiter_text, part_number) %}

    LTRIM(CAST(('<X>'+REPLACE({{ string_text }},{{ delimiter_text }} ,'</X><X>')+'</X>') AS XML).value('(/X)[{{ part_number }}]', 'VARCHAR(128)'))

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
    {% do return( tsql_utils.sqlserver__split_part(string_text, delimiter_text, part_number)) %}
{% endmacro %}
