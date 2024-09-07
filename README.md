# `tsql-utils`

This [dbt](https://www.getdbt.com/) package contains macros
that:

- can be (re)used across dbt projects running on T-SQL based database engines
- define implementations of [dispatched macros](https://docs.getdbt.com/reference/dbt-jinja-functions/adapter/#dispatch) from other packages that can be used on a database that speaks T-SQL: SQL Server, Azure SQL, Azure Synapse, Microsoft Fabric, etc.

## Compatibility

This package provides "shims" for:

- [dbt-utils](https://github.com/dbt-labs/dbt-utils) (partial)
- [dbt-date](https://github.com/calogica/dbt-date) (partial)
- [dbt-expectations](https://github.com/calogica/dbt-expectations) (partial)
- [dbt-audit-helper](https://github.com/dbt-labs/dbt-audit-helper) (partial)

Note that in 2024 we refactored all the T-SQL adapters to have [dbt-fabric](https://github.com/microsoft/dbt-fabric) as their base.
This means that you need to be using version 1.7 or newer of your adapter to use version 1.0.0 or newer of this package.

## Installation Instructions

To make use of these T-SQL adaptations in your dbt project, you must do two things:

1. Install both and `tsql-utils` and any of the compatible packages listed above by them to your `packages.yml`

    ```yaml
    packages:
      # and/or calogica/dbt-date; calogica/dbt-expectations; dbt-labs/dbt-audit-helper
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
dbt run-operation fabric__drop_schemas_by_prefixes --args "{prefixes: ['dev', 'myschema']}"
```

Drop all schemas with the single provided prefix (dev being a sample prefix):

```bash
dbt run-operation fabric__drop_schemas_by_prefixes --args "{prefixes: myschema}"
```

Drop a schema with a specific name (myschema_seed being a sample schema name used in the project):

```bash
dbt run-operation fabric__drop_schema_by_name --args "{schema_name: myschema_seed}"
```

Drop any models that are no longer included in the project (dependent on the current target):

```bash
dbt run-operation fabric__drop_old_relations
```

or for a dry run to preview dropped models:

```bash
dbt run-operation fabric__drop_old_relations --args "{dry_run: true}"
```
