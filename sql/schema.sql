CREATE TABLE IF NOT EXISTS teenagers (
    teen_id INTEGER PRIMARY KEY,
    age INTEGER NOT NULL,
    gender TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS platforms (
    platform_id INTEGER PRIMARY KEY,
    platform_name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS teen_platforms (
    teen_id INTEGER,
    platform_id INTEGER,
    PRIMARY KEY (teen_id, platform_id),
    FOREIGN KEY (teen_id) REFERENCES teenagers(teen_id) ON DELETE CASCADE,
    FOREIGN KEY (platform_id) REFERENCES platforms(platform_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS teen_metrics (
    teen_id INTEGER PRIMARY KEY,
    daily_social_media_hours REAL,
    sleep_hours REAL,
    screen_time_before_sleep REAL,
    academic_performance REAL,
    physical_activity REAL,
    social_interaction_level TEXT,
    stress_level INTEGER,
    anxiety_level INTEGER,
    addiction_level INTEGER,
    depression_label TEXT,
    FOREIGN KEY (teen_id) REFERENCES teenagers(teen_id) ON DELETE CASCADE
);

-- =========================================================
-- 2. DATA INGESTION & CLEANING PIPELINE (INSERT DATA)
-- =========================================================

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
