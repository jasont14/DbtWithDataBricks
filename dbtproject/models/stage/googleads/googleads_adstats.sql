{{
    config
    (        
        materialized='table'
        ,unique_key = 'devkey'
        ,pre_hook=[
        ]

        ,post_hook=[
        ]
    )

}}

SELECT
    concat_ws('|',_fivetran_id, customer_id,cast(date as varchar(255)),cast(conversions_value as varchar(255))) AS devkey
    ,ad_id
    ,ad_group_id
    ,ad_group_base_ad_group
    ,customer_id
    ,date
    ,conversions_value
    ,conversions
    ,interactions
    ,ad_network_type
    ,interaction_event_types
FROM {{ source('google_ads','ad_stats')}} 
WHERE date >  cast('2022-12-08' as date)

--If materialization is set to incremental run the following to limit those records to recently updated from timestamp
{% if is_incremental() %}
    where timestamp from rom {{this}} --where this is target table
{% endif %}