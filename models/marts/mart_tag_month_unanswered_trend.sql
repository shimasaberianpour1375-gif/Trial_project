{{ config(materialized='view') }}

with agg as (
  select
    f.month_key,
    b.tag_id,
    count(*) as question_count,
    sum(case when f.answered_flag then 1 else 0 end) as answered_count
  from {{ ref('fct_questions') }} f
  join {{ ref('bridge_question_tag') }} b on b.question_id = f.question_id
  group by 1,2
),

final as (
  select
    a.month_key,
    a.tag_id,
    a.question_count,
    a.answered_count,
    safe_divide(a.question_count - a.answered_count, a.question_count) as unanswered_rate,
    a.question_count - lag(a.question_count) over(partition by a.tag_id order by a.month_key) as mom_delta,
    safe_divide(
      a.question_count - lag(a.question_count) over(partition by a.tag_id order by a.month_key),
      nullif(lag(a.question_count) over(partition by a.tag_id order by a.month_key),0)
    ) as mom_growth
  from agg a
)

select
  f.month_key,
  d.year,
  d.month,
  t.tag_name,
  f.question_count,
  f.answered_count,
  f.unanswered_rate,
  f.mom_delta,
  f.mom_growth
from final f
left join {{ ref('dim_date') }} d
  on d.month_key = f.month_key
left join {{ ref('dim_tag') }} t
  on t.tag_id = f.tag_id