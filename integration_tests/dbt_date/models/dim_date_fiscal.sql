{{
    config(
        materialized = "table"
    )
}}
{{ tsql_utils.get_fiscal_periods(ref('dates'), year_end_month=1, week_start_day=1) }}
