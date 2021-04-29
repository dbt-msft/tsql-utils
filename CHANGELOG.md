# Changelog

## `0.6.7`

## New features

- shim dbt-date, currently passing all tests! [#36](https://github.com/dbt-msft/tsql-utils/pull/36)
- support for `dbt_utils.generate_series()` [#36](https://github.com/dbt-msft/tsql-utils/pull/36)
- support on synapse for `dbt_utils.dateadd()` and `dbt_utils.datediff()` [#36](https://github.com/dbt-msft/tsql-utils/pull/36)

### Under the hood
- add CI infrastucture for future support of dbt-expectations [#35](https://github.com/dbt-msft/tsql-utils/pull/35) thanks to [@b-per](https://github.com/b-per) for all the heaving lifting with [calogica/dbt-expectations #29](https://github.com/calogica/dbt-expectations/pull/29), [calogica/dbt-date #14](https://github.com/calogica/dbt-date/pull/14), and [calogica/dbt-date #15](https://github.com/calogica/dbt-date/pull/15) 

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