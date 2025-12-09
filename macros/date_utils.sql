{% macro get_seasons(column_name) %}
    CASE 
        WHEN MONTH(TO_TIMESTAMP({{ column_name }})) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(TO_TIMESTAMP({{ column_name }})) IN (3, 4, 5)  THEN 'Spring'
        WHEN MONTH(TO_TIMESTAMP({{ column_name }})) IN (6, 7, 8)  THEN 'Summer'
        ELSE 'Autumn'
    END
{% endmacro %}