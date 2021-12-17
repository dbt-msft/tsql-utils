# Changelog

## `v0.9.0`

### :rotating_light: breaking change

this package will only be compatible with dbt-core `v1.0.0` and greater which means it uses the following versions of packages:

- [dbt-utils v0.8.0](https://github.com/dbt-labs/dbt-utils/releases/tag/0.8.0)
- [dbt-external tables v0.8.0](https://github.com/dbt-labs/dbt-external-tables/releases/tag/0.8.0)
- [dbt-audit-helper v0.5.0](https://github.com/dbt-labs/dbt-audit-helper/releases/tag/0.5.0)
- [dbt-date v0.5.0](https://github.com/calogica/dbt-date/releases/tag/0.5.0)

## `v0.8.1`


We're back!!! dbt test definitions have been broken for a very long time in TSQL, this is now resolved. As such this package was finally able to be brought back under control again and up-to-date
### dependent pacakge versions

This pacakge will work best with dbt-sqlserver and dbtsynapse versions 0.21.0 and greater. Below are the package versions with which this package was built/tested.
- dbt-utils 0.7.4
- dbt-date 0.4.1
- dbt-audit-helper 0.4.0
- dbt-expectations ???
## What's Changed
* Updated docs to show current support model
* drop the manual redispatch of `synapse__` macros to `sqlserver__`. as of v0.20.0, this isn't needed  https://github.com/dbt-msft/tsql-utils/pull/64
* Fishtown -> dbt-labs by @visch in https://github.com/dbt-msft/tsql-utils/pull/55
* The insert by period materialization for TSQL by @davidclarance in https://github.com/dbt-msft/tsql-utils/pull/56

## New Contributors
* @visch made their first contribution in https://github.com/dbt-msft/tsql-utils/pull/55
* @davidclarance made their first contribution in https://github.com/dbt-msft/tsql-utils/pull/56
* @timdenouden made their first contribution in https://github.com/dbt-msft/tsql-utils/pull/58
## `v0.8.0`

- make compatible with dbt-core v0.20.0 [#59](https://github.com/dbt-msft/tsql-utils/pull/59) [#52](https://github.com/dbt-msft/tsql-utils/pull/52)
- added macros `sqlserver__drop_schema_by_name`, `sqlserver__drop_schemas_by_prefixes`, and `sqlserver__drop_old_relations` to help manage out of date and unused schemas by @timdenouden in https://github.com/dbt-msft/tsql-utils/pull/58

## `v0.7.2`

- fix to make the commented out SQL in `audit_helper.compare_queries()` TSQL compatible [#54](https://github.com/dbt-msft/tsql-utils/pull/54)

## `v0.7.1`

### New features

- additional shim support for dbt_date.from_unixtimestamp() [#53](https://github.com/dbt-msft/tsql-utils/pull/53)

## `v0.7.0`

### New features

- shim dbt-audit-helper, currently supports [v0.3.0](https://github.com/fishtown-analytics/dbt-audit-helper/releases/tag/0.3.0) : [compare_relations](https://github.com/fishtown-analytics/dbt-audit-helper#compare_relations-source), [compare_queries](https://github.com/fishtown-analytics/dbt-audit-helper#compare_queries-source) and [compare_column_values](https://github.com/fishtown-analytics/dbt-audit-helper#compare_column_values-source). Target to support [compare_relation_columns](https://github.com/fishtown-analytics/dbt-audit-helper#compare_relation_columns-source) in the next release. Thanks [@clrcrl](https://github.com/clrcrl) for the support!
- shim dbt-expectations, currently supports [v0.3.3](https://github.com/calogica/dbt-expectations/releases/tag/0.3.3) with most functionalities implemented. Limitations with regex and timeseries functionalities mostly for Synapse (Target next release to implement these). Thanks [@b-per](https://github.com/b-per) and [@clausherther](https://github.com/clausherther) for the support!

### Also supports
-  [dbt-utils - v0.6.6](https://github.com/fishtown-analytics/dbt-utils/releases/tag/0.6.6) (partial)
- [dbt-date - v0.2.6](https://github.com/calogica/dbt-date/releases/tag/0.2.6) (partial)

## `0.6.7`

### New features

- add support for `dbt_utils.surrogate_key()` [#32](https://github.com/dbt-msft/tsql-utils/pull/32) thanks [@infused-kim](https://github.com/infused-kim)
- shim dbt-date, currently passing all tests! [#36](https://github.com/dbt-msft/tsql-utils/pull/36)
- support for `dbt_utils.generate_series()` [#36](https://github.com/dbt-msft/tsql-utils/pull/36)
- support on synapse for `dbt_utils.dateadd()` and `dbt_utils.datediff()` [#36](https://github.com/dbt-msft/tsql-utils/pull/36)

### Under the hood
- add CI infrastucture for dbt-date and dbt-expectations [#35](https://github.com/dbt-msft/tsql-utils/pull/35) thanks to [@b-per](https://github.com/b-per) for all the heaving lifting with [calogica/dbt-expectations #29](https://github.com/calogica/dbt-expectations/pull/29), [calogica/dbt-date #14](https://github.com/calogica/dbt-date/pull/14), and [calogica/dbt-date #15](https://github.com/calogica/dbt-date/pull/15)
- docs refresh

## `0.6.6`

- fix for `dateadd()` macro when adding intervals smaller than a day [#35](https://github.com/dbt-msft/tsql-utils/pull/35) thanks [@b-per](https://github.com/b-per)!
## `0.6.5`

- syntactical update, because four-part version numbers aren't canonically SemVer.
## `0.6.4.1`

### Added
- add support for `date-spine` [#28](https://github.com/dbt-msft/tsql-utils/pull/28) thanks [@TwoMinds](https://github.com/TwoMinds)

## `0.6.4`

first release!

as of now, all 39 of dbt-utils's macros work on `dbt-sqlserver` and `dbt-synapse` except for the 10 listed below. We hope to bring these macros in a future release!

    insert_by_period materialization
    date_spine
    test_mutually_exclusive_ranges() #18
    all the url macros (get_url_host, get_url_path, get_url_host()
    generate_series()
    get_relations_by_pattern()
    get_relations_by_prefix_and_union()
    union_relations()

these 5 macros are supported for SQL Server and Azure SQL, but aren't yet officially supported right now on Synapse because of https://github.com/dbt-msft/dbt-synapse/issues/36 breaks dbt-utils's integration tests.  

    dateadd()
    datediff()
    split_part()
    last_day()
    test-hash()