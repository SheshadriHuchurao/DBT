{% snapshot employee_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='employee_id',
        strategy='check',
        check_cols='all',
        invalidate_hard_deletes=True
    )
}}

select
    {{ surrogate_key(['employee_id']) }} as employee_sk,
    *
from {{ ref('stg_postgres__employees') }}

{% endsnapshot %}