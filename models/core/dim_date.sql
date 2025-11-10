{{ config(materialized='table') }}

with d as (
  select * from unnest(generate_date_array(date('2017-01-01'), date('2022-11-30'))) as dt
)
select
  dt                               as date_key,       
  format_date('%Y%m%d', dt)        as date_id,           
  dt                               as date,
  extract(year  from dt)           as year,
  extract(month from dt)           as month,
  extract(day   from dt)           as day,
  format_date('%Y-%m', dt)         as month_key
from d
