{{
    config(
        materialized = "table"
    )
}}
{{ dbt_date.get_base_dates(n_dateparts=24*28, datepart="hour") }}
