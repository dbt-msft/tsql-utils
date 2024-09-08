{{
    config(
        materialized = "table"
    )
}}
with date_dimension as (
    select * from {{ ref('dates') }}
),
fiscal_periods as (
    select * from {{ ref('dim_date_fiscal') }}
)
select
    d.*,
    f.fiscal_week_of_year,
    f.fiscal_week_of_period,
    f.fiscal_period_number,
    f.fiscal_quarter_number,
    f.fiscal_period_of_quarter
from
    date_dimension d
    left join
    fiscal_periods f
        on d.date_day = f.date_day
