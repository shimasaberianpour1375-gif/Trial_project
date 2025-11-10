{{ config(materialized='view') }}

with last_month as (
  select max(month_key) as m
  from {{ ref('fct_questions') }}
),
bounds as (
 
  select
    format_date('%Y-%m', date_add(parse_date('%Y-%m', m), interval -23 month)) as start_m,
    m as end_m
  from last_month
)
select m.*
from {{ ref('mart_tag_month_unanswered_trend') }} m
join bounds b
  on m.month_key between b.start_m and b.end_m
