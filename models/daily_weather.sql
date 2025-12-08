-- models/daily_weather.sql

with daily_weather as (
    select 
        date(TIME)     as ride_date,
        WEATHER        as weather,
        HUMIDITY       as humidity,
        TEMP           as temp,
        PRESSURE       as pressure,
        CLOUDS         as clouds
    from {{ source('demo', 'weather') }}
    limit 100
),

daily_weather_agg as (
    select 
        ride_date,
        weather,
        AVG(HUMIDITY) as humidity,
        AVG(TEMP) as temp,
        AVG(PRESSURE) as pressure,
        AVG(CLOUDS) as clouds,
        count(*) as weather_count,

        row_number() over (
            partition by ride_date 
            order by count(*) desc
        ) as rn

    from daily_weather
    group by ride_date, weather
)

-- Only keep the #1 weather condition for each day
select 
    ride_date,
    humidity,
    pressure,
    clouds,
    temp,
    weather               as weatheroftheday
from daily_weather_agg
where rn = 1                     -- ← THIS IS THE KEY LINE
order by ride_date desc
