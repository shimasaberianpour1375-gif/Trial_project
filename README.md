# Stack Overflow Tag Unanswered Trend (dbt + BigQuery)

## Business objective
Identify monthly unanswered trend across Stack Overflow questions per tag to highlight topics where developers struggle and community support is weak.

## Source data
BigQuery public dataset:

`bigquery-public-data.stackoverflow.posts_questions`

## Data model

### Layers
- staging → clean raw question data
- intermediate → question enriched transformations
- dimensions → date / tag lookup tables
- fact → monthly questions per question id
- marts → KPI outputs

### Star schema
<img width="1884" height="422" alt="image" src="https://github.com/user-attachments/assets/42818aac-20ba-4250-83de-8b23ec33c826" />


**Fact table**
- `fct_questions`

**Dimensions**
- `dim_tag`
- `dim_date`

**Bridge**
- `bridge_question_tag` (because one question has multiple tags)

### Final mart
`mart_tag_month_unanswered_trend`  
monthly aggregation per tag

## Metrics delivered
- unanswered_rate
- MoM delta
- MoM growth
- answered count
- total monthly question volume per tag

## Output rows
fct_questions ~ 10.5M  
mart_tag_month_unanswered_trend ~ 44M

## Technology
- dbt Cloud
- BigQuery

## Notes
This model runs with table materialization and passes referential tests (dim_tag / dim_date / fact).
