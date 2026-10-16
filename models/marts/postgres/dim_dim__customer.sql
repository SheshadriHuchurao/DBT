select  {{ surrogate_key(['customer_id']) }} as customer_sk, *
from {{ ref('int_postgres__customers') }}