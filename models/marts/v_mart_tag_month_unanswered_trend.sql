{{ config(materialized='view') }}

select *
from {{ ref('mart_tag_month_unanswered_trend') }}