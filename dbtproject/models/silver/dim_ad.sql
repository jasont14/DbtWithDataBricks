{{
    config
    (
        materialized='table'
        ,unique_key = 'dimad_id'
        ,pre_hook=[
        ]
        ,post_hook=[
        ]
    )
}}

SELECT
{{ dbt_utils.surrogate_key(['gadh.id', 'gadh.type'])}}  AS dimad_id 
,gadh.id
,gadh.type
,gadh.display_url
,gadh.final_urls
,gads.interactions
,gads.interaction_event_types
FROM {{ ref('googleads_adhistory') }} gadh
JOIN  {{ ref('googleads_adstats') }} gads
	ON gadh.id = gads.ad_id
WHERE gadh.status = 'ENABLED'
