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
FROM {{ref('googleads_adhistory')}} as gadh
JOIN  {{ref('googleads_adstats')}} as gads
	ON gadh.id = gads.ad_id
WHERE gadh.status = 'ENABLED'
LIMIT 10