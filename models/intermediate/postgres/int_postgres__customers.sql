with final as (
    select 
        customer_id,
        customer_name,
        email,
        city,
        loyalty_tier,
        signup_date,
        updated_at
    from {{ ref ('stg_postgres__customers') }}
)

select * from final
