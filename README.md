# Stack Overflow Tag Unanswered Trend (dbt + BigQuery)
## Project links
- [Looker Studio Dashboard](https://lookerstudio.google.com/s/icf5w4u70h8)
- [BigQuery Project](https://console.cloud.google.com/bigquery?ws=!1m4!1m3!3m2!1snotional-gist-474313-e1!2sdbt_shimasaberianpour1375)
- [Google Document ](https://docs.google.com/document/d/10gjeLOtjLAX8jtwaD_nsiGkv81DkPkxBL7Ez9uqTY_k/edit?usp=sharing)

## Business objective
Track how many Stack Overflow questions stay unanswered for each tag month by month.  
The goal is to see which tags create more work for the community and which ones need support.

## Source data
**BigQuery public dataset**  
`bigquery-public-data.stackoverflow.posts_questions`

## Data model
<img width="940" height="157" alt="image" src="https://github.com/user-attachments/assets/77bac2ab-c1b5-4bdb-8b12-ae97a557ecce" />

### Layers
- staging → clean the raw question data
- intermediate → add helpful fields for modelling
- dimensions → date and tag lookup tables
- fact → monthly question level
- marts → final KPI tables used in the dashboard

### Star schema
**Fact table**
- fct_questions

**Dimensions**
- dim_tag
- dim_date

**Bridge**
- bridge_question_tag (because one question can have several tags)

**Final mart**
- mart_tag_month_unanswered_trend → monthly rollup per tag

## Metrics delivered
- unanswered_rate
- answered_count
- total_question_count
- MoM delta
- MoM growth

## Output rows
- fct_questions about 10.5M
- mart_tag_month_unanswered_trend about 44M

## Technology
- dbt Cloud
- BigQuery

## Tests and materialization
- Referential tests between dim_tag, dim_date and fct_questions
- Models materialized as tables for better performance

## Dashboard summary
- Unanswered Rate Trend (2022) shows how the main tags behave during the year
- Risk view for Sept 2022 shows tags with both high volume and high unanswered rate
- MoM comparison helps spot tags that are getting worse or slowing down
- Core tag table lets you filter and check exact values for the six tags in the analysis

## Dashboard preview 
<img width="738" height="382" alt="image" src="https://github.com/user-attachments/assets/614c00b9-75cd-495a-8f5a-4c5f06c43de4" />

