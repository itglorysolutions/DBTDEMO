-- models/staging/stg_bike_started_at.sql   (or any name you like)

WITH cleaned_data AS (
    SELECT
        TO_TIMESTAMP(started_at)                                      AS started_at,
        
        DATE(TO_TIMESTAMP(started_at))                                AS date_started_at,
        HOUR(TO_TIMESTAMP(started_at))                                AS hour_started_at,
        DAYNAME(TO_TIMESTAMP(started_at))                             AS day_name_started_at,
        MONTH(TO_TIMESTAMP(started_at))                               AS month_started_at,
        
        -- Day type: Weekend or Business day
        CASE 
            WHEN DAYNAME(TO_TIMESTAMP(started_at)) IN ('Sat', 'Sun') 
                THEN 'WEEKEND'
            ELSE 'BUSINESS'
        END                                                           AS day_type,
        
        -- Season based on month
        CASE 
            WHEN MONTH(TO_TIMESTAMP(started_at)) IN (12, 1, 2)         THEN 'Winter'
            WHEN MONTH(TO_TIMESTAMP(started_at)) IN (3, 4, 5)          THEN 'Spring'
            WHEN MONTH(TO_TIMESTAMP(started_at)) IN (6, 7, 8)          THEN 'Summer'
            ELSE 'Autumn'
        END                                                           AS season

    FROM {{ source('demo', 'bike') }}
    WHERE started_at IS NOT NULL                     -- safety first
      AND TRIM(started_at) != ''                     
      AND started_at != 'started_at'                -- removes header row if present
      AND started_at != 'started_at'                 -- your original condition
)

-- Final output – only 10 rows for quick testing
SELECT *
FROM cleaned_data
