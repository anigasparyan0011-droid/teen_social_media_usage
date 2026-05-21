PRAGMA foreign_keys = ON;

DELETE FROM teen_platforms;
DELETE FROM teen_metrics;
DELETE FROM platforms;
DELETE FROM teenagers;

INSERT INTO teenagers (
    teen_id,
    age,
    gender
)
SELECT
    teen_id,
    age,
    LOWER(TRIM(gender)) AS gender
FROM raw_with_id;

INSERT INTO platforms (
    platform_id,
    platform_name
)
VALUES
    (1, 'Instagram'),
    (2, 'TikTok');

INSERT INTO teen_metrics (
    teen_id,
    daily_social_media_hours,
    sleep_hours,
    screen_time_before_sleep,
    academic_performance,
    physical_activity,
    social_interaction_level,
    stress_level,
    anxiety_level,
    addiction_level,
    depression_label
)
SELECT
    teen_id,
    daily_social_media_hours,
    sleep_hours,
    screen_time_before_sleep,
    academic_performance,
    physical_activity,
    LOWER(TRIM(social_interaction_level)) AS social_interaction_level,
    stress_level,
    anxiety_level,
    addiction_level,
    depression_label
FROM raw_with_id;

INSERT INTO teen_platforms (
    teen_id,
    platform_id
)
SELECT
    r.teen_id,
    p.platform_id
FROM raw_with_id r
JOIN platforms p
    ON TRIM(r.platform_usage) = p.platform_name
WHERE TRIM(r.platform_usage) IN ('Instagram', 'TikTok');

INSERT INTO teen_platforms (
    teen_id,
    platform_id
)
SELECT
    r.teen_id,
    p.platform_id
FROM raw_with_id r
JOIN platforms p
    ON p.platform_name = 'Instagram'
WHERE TRIM(r.platform_usage) = 'Both';

INSERT INTO teen_platforms (
    teen_id,
    platform_id
)
SELECT
    r.teen_id,
    p.platform_id
FROM raw_with_id r
JOIN platforms p
    ON p.platform_name = 'TikTok'
WHERE TRIM(r.platform_usage) = 'Both';
