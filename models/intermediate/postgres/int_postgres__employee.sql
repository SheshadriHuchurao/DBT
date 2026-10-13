with final as (
    select * from {{ref('stg_postgres__employees')}}
)

select * from final
