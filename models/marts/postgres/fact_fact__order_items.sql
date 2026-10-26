{{ config(materialized='incremental',  
          unique_key='order_item_id',
          incremental_strategy='merge') }}
select * from {{ ref('stg_postgres__order_items') }}
{% if is_incremental() %}
where updated_at >= (
  select coalesce(max(updated_at), '1900-01-01')
  from {{ this }})
{% endif %}
