With Trips as (

    Select
    RIDE_ID,
    RIDEABLE_TYPE,
    Date(To_TimeStamp(Started_At)) as Trip_Date,
    start_station_name as Start_Station_Name,
    Start_statio_id as Station_id,
    Member_CSUAL as Member_CASUAL,
    End_Station_id,
    TimeStampDiff(second , (To_TimeStamp(started_at)) , (To_TimeStamp(ended_At))) as Trip_duration_seconds,
    From {{ source('demo', 'bike') }}
    Where ride_id != 'ride_id'

)


Select 
*
From 
Trips