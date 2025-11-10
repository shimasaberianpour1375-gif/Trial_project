with link as (
  select question_id, tag_name
  from {{ ref('int_question_tag_link') }}
),
tags as (
  select tag_id, tag_name
  from {{ ref('dim_tag') }}
),
fact as (
  select question_id
  from {{ ref('fct_questions') }}   -- فقط سوال‌های موجود در فکت
)

select distinct
  l.question_id,
  t.tag_id
from link l
join fact f using (question_id)
join tags t using (tag_name)
