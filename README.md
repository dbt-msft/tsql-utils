# `tsql-utils`

This [dbt](https://github.com/fishtown-analytics/dbt) package contains macros 
that:
- can be (re)used across dbt projects running on Azure databases
- define implementations of [dispatched macros](https://docs.getdbt.com/reference/dbt-jinja-functions/adapter/#dispatch) from other packages that can be used on a database that speaks T-SQL: SQL Server, Azure SQL, Azure Synapse, etc.

## Compatibility

This package provides "shims" for:
- [dbt-utils](https://github.com/fishtown-analytics/dbt-utils) (partial)
- [dbt-date](https://github.com/calogica/dbt-date) (partial)
- [dbt-expectations](https://github.com/calogica/dbt-expectations) (limited regex & timeseries functionalities)
- [dbt-audit-helper](https://github.com/fishtown-analytics/dbt-audit-helper) (except [compare_relation_columns](https://github.com/fishtown-analytics/dbt-audit-helper#compare_relation_columns-source))


## Usage

Wherever a custom tsql macro exists, dbt_utils adapter dispatch will pass to tsq_utils. This means you can just do `{{dbt_utils.hash('mycolumnname')}}` just like your friends with Snowflake. 

## Installation Instructions

To make use of these TSQL adaptations in your dbt project, you must do two things:
1. Install both and `tsql-utils` and any of the compatible packages listed above by them to your `packages.yml`
    ```yaml
    packages:
      # and/or calogica/dbt-date; calogica/dbt-expectations; fishtown-analytics/dbt-audit-helper
      - package: dbt-labs/dbt_utils 
        version: {SEE DBT HUB FOR NEWEST VERSION}
      - package: dbt-msft/tsql_utils
        version: {SEE DBT HUB FOR NEWEST VERSION}
    ```
2. Tell the supported package to also look for the `tsql-utils` macros by adding the relevant `dispatches` to your `dbt_project.yml`
    ```yaml
    dispatch:
      - macro_namespace: dbt_utils
        search_order: ['tsql_utils', 'dbt_utils']
      - macro_namespace: dbt_date
        search_order: ['tsql_utils', 'dbt_date']
      - macro_namespace: dbt_expectations
        search_order: ['tsql_utils', 'dbt_expectations']
      - macro_namespace: audit_helper
        search_order: ['tsql_utils', 'audit_helper']
    ```
Check [dbt Hub](https://hub.getdbt.com) for the latest installation 
instructions, or [read the docs](https://docs.getdbt.com/docs/package-management) 
for more information on installing packages.

## tsql-utils specific macros

### Cleanup Macros

Some helper macros have been added to simplfy development database cleanup. Usage is as follows:

Drop all schemas for each prefix with the provided prefix list (dev and myschema being a sample prefixes):
```bash
dbt run-operation sqlserver__drop_schemas_by_prefixes --args "{prefixes: ['dev', 'myschema']}"
```

Drop all schemas with the single provided prefix (dev being a sample prefix):
```bash
dbt run-operation sqlserver__drop_schemas_by_prefixes --args "{prefixes: myschema}"
```

Drop a schema with a specific name (myschema_seed being a sample schema name used in the project):
```bash
dbt run-operation sqlserver__drop_schema_by_name --args "{schema_name: myschema_seed}"
```

Drop any models that are no longer included in the project (dependent on the current target):
```bash
dbt run-operation sqlserver__drop_old_relations
```
or for a dry run to preview dropped models:
```bash
dbt run-operation sqlserver__drop_old_relations --args "{dry_run: true}"
```

## macro support

### Legend

Macro Support

generally, SQL Server and Azure SQL have a larger scope of SQL commands that are implemented. So sometimes commands are not supported on Synapse. Additionally, some common SQL conventions are not supported in TSQL, so it will never be possible to port a macro that uses it.

- :sparkle:: dbt-utils's version works without modification
- :white_check_mark:: works in dbt-synapse and dbt-sqlserver
- :ballot_box_with_check:: works only in dbt-sqlserver
- :o:: still needs to be ported to TSQL
- :x:: will never work in TSQL

Integration test support:

Sometimes, the macros work, but the integration tests used to let us know if they're working when making pull requests do not work. So we disable the test. The takeaway is to be somewhat-leery of building a dependency on this macro.

- :white_check_mark:: works in dbt-synapse and dbt-sqlserver
- :ballot_box_with_check:: works only in dbt-sqlserver
- :o:: strange bugfix going onL
- :x:: doesn't work

### dbt-utils

Read more about these macros in the [dbt-utils package repo](https://github.com/dbt-labs/dbt-utils).

| category             | name                          | supported               | integration test        | dbt-utils docs |
|----------------------|-------------------------------|-------------------------|-------------------------|----------------|
| schema test          | equal_rowcount                | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#equal_rowcount-source) |
| schema test          | equality                      | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#equality-source) |
| schema test          | expression_is_true            | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#expression_is_true-source) |
| schema test          | recency                       | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#recency-source) |
| schema test          | at_least_one                  | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#at_least_one-source) |
| schema test          | not_constant                  | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#not_constant-source) |
| schema test          | cardinality_equality          | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#cardinality_equality-source) |
| schema test          | unique_where                  | :white_check_mark:      | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#unique_where-source) |
| schema test          | not_null_where                | :white_check_mark:      | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#not_null_where-source) |
| schema test          | not_null_proportion           | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#not_null_proportion-source) |
| schema test          | relationships_where           | :white_check_mark:      | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#relationships_where-source) |
| schema test          | mutually_exclusive_ranges     | :o:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#mutually_exclusive_ranges-source) |
| schema test          | unique_combination_of_columns | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#unique_combination_of_columns-source) |
| schema test          | accepted_range                | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#accepted_range-source) |
| introspective macros | get_column_values             | :x:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#get_column_values-source) |
| introspective macros | get_relations_by_pattern      | :x:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#get_relations_by_pattern-source) |
| introspective macros | get_relations_by_prefix       | :x:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#get_relations_by_prefix-source) |
| introspective macros | get_query_results_as_dict     | :white_check_mark:      | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#get_query_results_as_dict-source) |
| SQL generators       | date_spine                    | :white_check_mark:      | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#date_spine-source) |
| SQL generators       | haversine_distance            | :white_check_mark:      | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#haversine_distance-source) |
| SQL generators       | group_by                      | :x:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#group_by-source) |
| SQL generators       | star                          | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#star-source) |
| SQL generators       | union_relations               | :sparkle:               | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#union_relations-source) |
| SQL generators       | generate_series               | :white_check_mark:      | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#generate_series-source) |
| SQL generators       | hash                          | :ballot_box_with_check: | :ballot_box_with_check: | [:link:](https://github.com/dbt-labs/dbt-utils#hash-source) |
| SQL generators       | surrogate_key                 | :white_check_mark:      | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#surrogate_key-source) |
| SQL generators       | safe_add                      | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#safe_add-source) |
| SQL generators       | pivot                         | :sparkle:               | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#pivot-source) |
| SQL generators       | unpivot                       | :x:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#unpivot-source) |
| SQL generators       | unpivot_bool                  | :x:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#unpivot_bool-source) |
| web                  | get_url_parameter             | :x:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#get_url_parameter-source) |
| web                  | get_url_host                  | :x:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#get_url_host-source) |
| web                  | get_url_path                  | :x:                     | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#get_url_path-source) |
| cross database       | current_timestamp             | :white_check_mark:      | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#current_timestamp-source) |
| cross database       | dateadd                       | :ballot_box_with_check: | :ballot_box_with_check: | [:link:](https://github.com/dbt-labs/dbt-utils#dateadd-source) |
| cross database       | datediff                      | :ballot_box_with_check: | :ballot_box_with_check: | [:link:](https://github.com/dbt-labs/dbt-utils#datediff-source) |
| cross database       | split_part                    | :ballot_box_with_check: | :ballot_box_with_check: | [:link:](https://github.com/dbt-labs/dbt-utils#split_part-source) |
| cross database       | last_day                      | :white_check_mark:      | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#last_day-source) |
| cross database       | width_bucket                  | :white_check_mark:      | :white_check_mark:      | [:link:](https://github.com/dbt-labs/dbt-utils#width_bucket-source) |
| jinja helpers        | pretty_time                   | :white_check_mark:      | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#pretty_time-source) |
| jinja helpers        | pretty_log_format             | :white_check_mark:      | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#pretty_log_format-source) |
| jinja helpers        | log_info                      | :white_check_mark:      | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#log_info-source) |
| materializations     | insert_by_period              | :white_check_mark:      | :x:                     | [:link:](https://github.com/dbt-labs/dbt-utils#insert_by_period-source) |


### dbt-date

Read more about these macros in the [dbt-date package repo](https://github.com/calogica/dbt-date).

| category       | name               | supported               | integration test        |
|----------------|--------------------|-------------------------|-------------------------|
| Date Dimension | get_date_dimension | :white_check_mark:      | :white_check_mark:      |
| Fiscal Periods | get_fiscal_periods | :white_check_mark:      | :x:                     |
| Date           | convert_timezone   | :white_check_mark:      | :white_check_mark:      |
| Date           | date_part          | :white_check_mark:      | :white_check_mark:      |
| Date           | day_name           | :white_check_mark:      | :white_check_mark:      |
| Inner          | day_of_month       | :white_check_mark:      | :white_check_mark:      |
| Inner          | day_of_week        | :white_check_mark:      | :white_check_mark:      |
| Inner          | day_of_year        | :white_check_mark:      | :white_check_mark:      |
| Inner          | week_start         | :white_check_mark:      | :white_check_mark:      |
| Inner          | week_end           | :white_check_mark:      | :white_check_mark:      |
| Inner          | week_of_year       | :white_check_mark:      | :white_check_mark:      |
| Inner          | iso_week_start     | :white_check_mark:      | :white_check_mark:      |
| Inner          | iso_week_end       | :white_check_mark:      | :white_check_mark:      |
| Inner          | iso_week_of_year   | :white_check_mark:      | :white_check_mark:      |
| Date           | last_week          | :white_check_mark:      | :x:                     |
| Date           | month_name         | :white_check_mark:      | :x:                     |
| Date           | n_days_ago         | :white_check_mark:      | :x:                     |
| Date           | n_days_away        | :white_check_mark:      | :x:                     |
| Date           | n_months_ago       | :white_check_mark:      | :x:                     |
| Date           | n_months_away      | :white_check_mark:      | :x:                     |
| Date           | n_weeks_ago        | :white_check_mark:      | :x:                     |
| Date           | n_weeks_away       | :white_check_mark:      | :x:                     |
| Date           | now                | :white_check_mark:      | :x:                     |
| Date           | periods_since      | :white_check_mark:      | :x:                     |
| Date           | this_week          | :white_check_mark:      | :x:                     |
| Date           | from_unixtimestamp | :white_check_mark:      | :white_check_mark:      |
| Date           | to_unixtimestamp   | :white_check_mark:      | :white_check_mark:      |
| Date           | today              | :white_check_mark:      | :white_check_mark:      |
| Date           | tomorrow           | :white_check_mark:      | :white_check_mark:      |
| Date           | yesterday          | :white_check_mark:      | :white_check_mark:      |
### dbt-audit-helper

Read more about these macros in the [audit-helper package repo](https://github.com/dbt-labs/dbt-audit-helper).


| name                     | supported          | integration test   |
|--------------------------|--------------------|--------------------|
| compare_relations        | :white_check_mark: | :white_check_mark: |
| compare_queries          | :white_check_mark: | :white_check_mark: |
| compare_column_values    | :white_check_mark: | :white_check_mark: |
| compare_relation_columns | :x:                | :x:                |


### dbt-expectations

Read more about these macros in the [dbt-expectations package repo](https://github.com/calogica/dbt-expectations/).

use at your own risk! it was supported at once point, but the code base has evolved significantly since to include many nested CTEs, which aren't suported today in TSQL. [Click here](https://feedback.azure.com/d365community/idea/ae896b78-7c37-ec11-a819-000d3ae2b306) to upvote and get the feature supported!
