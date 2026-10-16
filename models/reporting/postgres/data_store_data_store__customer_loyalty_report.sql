select
  c.customer_id,
  c.loyalty_tier,
  t.benefits
from {{ ref('dim_dim__customer') }} c
left join {{ ref('loyalty_tiers') }} t
  on c.loyalty_tier = t.tier