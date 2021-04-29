# `tsql-utils`

This [dbt](https://github.com/fishtown-analytics/dbt) package contains macros 
that:
- can be (re)used across dbt projects running on Azure databases
- define implementations of [dispatched macros](https://docs.getdbt.com/reference/dbt-jinja-functions/adapter/#dispatch) from other packages that can be used on a database that speaks T-SQL: SQL Server, Azure SQL, Azure Synapse, etc.

## Compatibility

This package provides "shims" for:
- [dbt-utils](https://github.com/fishtown-analytics/dbt-utils) (partial)
- [dbt-date](https://github.com/calogica/dbt-date) (partial)
- (coming soon!) [dbt-expectations](https://github.com/calogica/dbt-expectations) (coming soon!)


## Usage

Wherever a custom tsql macro exists, dbt_utils adapter dispatch will pass to tsq_utils. This means you can just do `{{dbt_utils.hash('mycolumnname')}}` just like your friends with Snowflake. 


## Installation Instructions

To make use of these TSQL adaptations in your dbt project, you must do two things:
1. Install both and `tsql-utils` and any of the compatible packages listed above by them to your `packages.yml`
    ```yaml
    packages:
      # and/or calogica/dbt-date; calogica/dbt-expectations
      - package: fishtown-analytics/dbt_utils 
        version: {SEE DBT HUB FOR NEWEST VERSION}
      - package: dbt-msft/tsql_utils
        version: {SEE DBT HUB FOR NEWEST VERSION}
    ```
2. Tell the supported package to also look for the `tsql-utils` macros by adding the relevant variables to your `dbt_project.yml`
    ```yaml
    vars:
      dbt_utils_dispatch_list: ['tsql_utils']
      dbt_date_dispatch_list: ['tsql_utils']
      dbt_expectations_dispatch_list: ['tsql_utils']
    ```
Check [dbt Hub](https://hub.getdbt.com) for the latest installation 
instructions, or [read the docs](https://docs.getdbt.com/docs/package-management) 
for more information on installing packages.