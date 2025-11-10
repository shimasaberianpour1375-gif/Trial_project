select
  question_id,
  creation_date                       as date_key,
  format_date('%Y-%m', creation_date) as month_key,
  cast(answer_count > 0 or accepted_answer_id is not null as bool) as answered_flag,
  answer_count,
  score,
  view_count
from {{ ref('stg_posts_questions') }}
