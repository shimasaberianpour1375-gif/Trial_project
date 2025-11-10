with src as (
  select *
 from {{ source('so','posts_questions') }}
  where post_type_id = 1       
)

select
  cast(id as int64) as question_id,
  creation_date as creation_ts,
  date(creation_date) as creation_date,
  cast(answer_count as int64) as answer_count,
  cast(accepted_answer_id as int64) as accepted_answer_id,
  cast(score as int64) as score,
  cast(view_count as int64) as view_count,
  tags
from src
