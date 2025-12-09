With wbc as (

Select
t.*,
w.*
from {{ ref('trip_fact') }} t
left join {{ ref('daily_weather') }} w
on t.Trip_Date = w.ride_date
)


Select 
* 
From 
wbc