{{ config(
  materialized='table',
  partition_by={'field': 'month_start', 'data_type': 'date'},
  cluster_by=['month_key']
) }}

with src as (
  select
    q.question_id,
    cast(q.date_key as date) as date_key,
    date_trunc(cast(q.date_key as date), month) as month_start,  -- پارتیشن ماهانه
    q.month_key,
    q.answered_flag,
    q.answer_count,
    q.score,
    q.view_count,
    current_timestamp() as load_ts
  from {{ ref('int_questions_enriched') }} q
  where q.date_key between date('2017-01-01') and date('2022-09-25')  -- بر اساس min/max واقعی تو
)

select * from src
