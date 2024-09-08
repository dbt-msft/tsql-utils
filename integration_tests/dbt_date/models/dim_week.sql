{{
    config(
        materialized = "table"
    )
}}
{{ dbt_date.get_base_dates(n_dateparts=52, datepart="week") }}
