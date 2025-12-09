With bike as (

    Select
    distinct
    Start_statio_id as Station_id,
    start_station_name as station_name,
    start_lat,
    start_lng

    From {{ ref('stg_bike') }}

)


Select 
*
From 
bike