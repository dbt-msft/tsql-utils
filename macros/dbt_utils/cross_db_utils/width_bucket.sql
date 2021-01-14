{% macro sqlserver__width_bucket(expr, min_value, max_value, num_buckets) -%}

    {% set bin_size -%}
    (( {{ max_value }} - {{ min_value }} ) / {{ num_buckets }} )
    {%- endset %}
    (
        -- to break ties when the amount is exactly at the bucket edge
        case
            when
                {{ dbt_utils.safe_cast(expr, dbt_utils.type_numeric() ) }} %
                {{ dbt_utils.safe_cast(bin_size, dbt_utils.type_numeric() ) }}
                 = 0
            then 1
            else 0
        end
    ) +
      -- Anything over max_value goes the N+1 bucket
    {%- set ceil_val -%}
    CEILING(({{ expr }} - {{ min_value }})/{{ bin_size }})
    {%- endset %}
    (case when {{ ceil_val }} > ({{ num_buckets }} + 1)
        then {{ num_buckets }} + 1
        else {{ ceil_val }}
    end)
   
{%- endmacro %}

{% macro synapse__width_bucket(expr, min_value, max_value, num_buckets) -%}
    {% do return( tsql_utils.sqlserver__width_bucket(expr, min_value, max_value, num_buckets)) %}
{%- endmacro %}