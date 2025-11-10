with src as (
  select
    question_id,
    tags
  from {{ ref('stg_posts_questions') }}
  where tags is not null
),

arr as (
  select
    question_id,
    split(tags,'|') as tag_list     
  from src
)

select
  question_id,
  lower(trim(tag)) as tag_name
from arr, unnest(tag_list) as tag
where length(trim(tag)) > 0
