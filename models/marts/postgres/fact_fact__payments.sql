{{ config(
    post_hook="{{ audit('MODEL_BUILT', 'fact_fact_payments') }}"
) }}

-- Keep your existing payments SELECT query here

select * from {{ ref('int_postgres__payments') }}
