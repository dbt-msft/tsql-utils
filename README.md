This [dbt](https://github.com/fishtown-analytics/dbt) package contains macros 
that:
- can be (re)used across dbt projects running on Azure databases
- define implementations of [dispatched macros](https://docs.getdbt.com/reference/dbt-jinja-functions/adapter/#dispatch) from other packages that can be used on a database that speaks T-SQL: SQL Server, Azure DW, Azure Synapse, ...

## Installation Instructions

Check [dbt Hub](https://hub.getdbt.com) for the latest installation 
instructions, or [read the docs](https://docs.getdbt.com/docs/package-management) 
for more information on installing packages.

----

## Compatibility

This package provides "shims" for:
- [dbt_utils](https://github.com/fishtown-analytics/dbt-utils) (partial)

## Contributions

t-sql-utils applies for 2 adapters, sqlserver and synapse.

Therefore, for the time being, a macro should be implemented twice, once for the functionality and once as a reference for the second adapter. 

Imagine an adapter plugin, dbt-synapse, that inherits from dbt-sqlserver.
For the time being, we need to explicitly reimplement sqlserver__ macros as synapse__ macros. This looks like: 

```
{% macro synapse__get_tables_by_pattern_sql(field) %}
    {% do return(sqlserver__get_tables_by_pattern_sql(schema_pattern, table_pattern, exclude='', database=target.database)) %}
{% endmacro %}
```

TODO: We can make a small change to dbt-core (https://github.com/fishtown-analytics/dbt/issues/2923) that will make the inheritance of dispatched macros work just like the inheritance of other adapter objects, and render the following code redundant.