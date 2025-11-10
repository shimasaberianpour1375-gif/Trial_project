select
  farm_fingerprint(tag_name) as tag_id,
  tag_name
from {{ ref('int_question_tag_link') }}
group by 1,2
