# `tsql-utils`

This [dbt](https://github.com/fishtown-analytics/dbt) package contains macros 
that:
- can be (re)used across dbt projects running on Azure databases
- define implementations of [dispatched macros](https://docs.getdbt.com/reference/dbt-jinja-functions/adapter/#dispatch) from other packages that can be used on a database that speaks T-SQL: SQL Server, Azure SQL, Azure Synapse, etc.

## Installation Instructions

To make use of these TSQL adaptations in your dbt project, you must do two things:
1. Install both `dbt-utils` and `tsql-utils` by adding the following to your `packages.yml`
    ```yaml
    packages:
      - package: fishtown-analytics/dbt_utils
        version: 0.6.4.1
      - package: dbt-msft/tsql_utils
        version: 0.6.4.1
    ```
2. Tell `dbt-utils` to also look for the `tsql-utils` macros by adding this section to your `dbt_project.yml`
    ```yaml
    vars:
      dbt_utils_dispatch_list: ['tsql_utils']
    ```
Check [dbt Hub](https://hub.getdbt.com) for the latest installation 
instructions, or [read the docs](https://docs.getdbt.com/docs/package-management) 
for more information on installing packages.

----

## Usage

Wherever a custom tsql macro exists, dbt_utils adapter dispatch will pass to tsq_utils. This means you can just do `{{dbt_utils.hash('mycolumnname')}}` just like your friends with Snowflake. 

## Compatibility

This package provides "shims" for:
- [dbt_utils](https://github.com/fishtown-analytics/dbt-utils) (partial)