select {{ surrogate_key(['customer_id']) }} as customer_sk, *
from {{ ref('stg_postgres__customers') }}