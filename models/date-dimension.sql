-- models/staging/stg_bike_started_at.sql

WITH cleaned_data AS (
    SELECT
        TO_TIMESTAMP(started_at)                    AS started_at,
        DATE(TO_TIMESTAMP(started_at))              AS date_started_at,
        HOUR(TO_TIMESTAMP(started_at))              AS hour_started_at,
        DAYNAME(TO_TIMESTAMP(started_at))           AS day_name_started_at,
        MONTH(TO_TIMESTAMP(started_at))             AS month_started_at,

        -- Weekend or Business day
        CASE 
            WHEN DAYNAME(TO_TIMESTAMP(started_at)) IN ('Sat', 'Sun') 
                THEN 'WEEKEND'
            ELSE 'BUSINESS'
        END                                         AS day_type,

        -- Using your macro correctly
        {{ get_seasons('started_at') }}             AS season

    FROM {{ source('demo', 'bike') }}
    WHERE started_at IS NOT NULL
      AND TRIM(started_at) != ''
      AND LOWER(started_at) != 'started_at'   -- safer
)

-- Final select with test limit
SELECT *
FROM cleaned_data
