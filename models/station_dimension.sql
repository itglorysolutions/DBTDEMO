With bike as (

    Select
    distinct
    Start_statio_id,
    start_station_name as station_name,
    start_lat,
    start_lng

    From {{ source('demo', 'bike') }}

)


Select 
*
From 
bike