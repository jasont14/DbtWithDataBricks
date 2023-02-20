{{
    config
    (
        materialized='table'
        ,unique_key = 'adhistory_key'
        ,pre_hook=[

        ]

        ,post_hook=[

        ]
    )

}}

SELECT
    concat_ws('|',ad_group_id, id, _fivetran_synced) AS adhistory_key
    ,ad_group_id
    ,id
    ,type
    ,updated_at
    ,ad_strength
    ,device_preference
    ,final_urls
    ,display_url
    ,policy_summary_approval_status
    ,policy_summary_review_status
    ,status
FROM {{ source('google_ads','ad_history')}} 
WHERE updated_at >  cast('2022-12-08' as date)