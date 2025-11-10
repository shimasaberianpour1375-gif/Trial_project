{{ config(materialized='table') }}

select
  q.question_id,
  cast(q.date_key as date)       as date_key,
  q.month_key,                   -- keep the original YYYY-MM string
  q.answered_flag,
  q.answer_count,
  q.score,
  q.view_count
from {{ ref('int_questions_enriched') }} q
where q.date_key >= date('2017-01-01')
  and q.date_key <= date('2022-09-25')   -- your real max date
