-- 1. Compare average daily social media usage by gender
DROP VIEW IF EXISTS view_01_gender_usage;
CREATE VIEW view_01_gender_usage AS
SELECT 
    t.gender,
    COUNT(t.teen_id) AS total_teenagers,
    AVG(tm.daily_social_media_hours) AS avg_daily_social_media_hours
FROM teenagers t
JOIN teen_metrics tm ON t.teen_id = tm.teen_id
GROUP BY t.gender;


-- 2. Compare platform user counts after normalization
DROP VIEW IF EXISTS view_02_platform_user_counts;
CREATE VIEW view_02_platform_user_counts AS
SELECT 
    p.platform_name,
    COUNT(tp.teen_id) AS total_user_count
FROM platforms p
JOIN teen_platforms tp ON p.platform_id = tp.platform_id
GROUP BY p.platform_name;


-- 3. Compare average stress level by platform
DROP VIEW IF EXISTS view_03_stress_by_platform;
CREATE VIEW view_03_stress_by_platform AS
SELECT 
    p.platform_name,
    COUNT(tp.teen_id) AS platform_users,
    AVG(tm.stress_level) AS avg_stress_level,
    AVG(tm.anxiety_level) AS avg_anxiety_level
FROM platforms p
JOIN teen_platforms tp ON p.platform_id = tp.platform_id
JOIN teen_metrics tm ON tp.teen_id = tm.teen_id
GROUP BY p.platform_name;


-- 4. Compare depression rate by platform
DROP VIEW IF EXISTS view_04_depression_by_platform;
CREATE VIEW view_04_depression_by_platform AS
SELECT 
    p.platform_name,
    COUNT(tp.teen_id) AS total_users,
    AVG(m.depression_label) AS depression_rate
FROM platforms p
JOIN teen_platforms tp ON p.platform_id = tp.platform_id
JOIN teen_metrics m ON tp.teen_id = m.teen_id
GROUP BY p.platform_name;


-- 5. Study anxiety level across daily social media usage groups
DROP VIEW IF EXISTS view_05_anxiety_by_social_usage;
CREATE VIEW view_05_anxiety_by_social_usage AS
SELECT 
    CASE 
        WHEN m.daily_social_media_hours < 2 THEN 'Low usage. Less than 2 hours'
        WHEN m.daily_social_media_hours >= 2 AND m.daily_social_media_hours <= 5 THEN 'Medium usage. 2 to 5 hours'
        ELSE 'High usage. More than 5 hours'
    END AS usage_group,
    AVG(m.anxiety_level) AS avg_anxiety_level
FROM teen_metrics m
GROUP BY usage_group;


-- 6. Compare stress level across sleep-hour groups
DROP VIEW IF EXISTS view_06_stress_by_sleep;
CREATE VIEW view_06_stress_by_sleep AS
SELECT 
    CASE 
        WHEN m.sleep_hours < 6 THEN 'Less than 6 hours'
        WHEN m.sleep_hours >= 6 AND m.sleep_hours <= 8 THEN '6 to 8 hours'
        ELSE 'More than 8 hours'
    END AS sleep_group,
    AVG(m.stress_level) AS avg_stress_level
FROM teen_metrics m
GROUP BY sleep_group;


-- 7. Compare academic performance across social media usage groups
DROP VIEW IF EXISTS view_07_academics_by_social_usage;
CREATE VIEW view_07_academics_by_social_usage AS
SELECT 
    CASE 
        WHEN m.daily_social_media_hours < 2 THEN 'Low usage. Less than 2 hours'
        WHEN m.daily_social_media_hours >= 2 AND m.daily_social_media_hours <= 5 THEN 'Medium usage. 2 to 5 hours'
        ELSE 'High usage. More than 5 hours'
    END AS usage_group,
    AVG(m.academic_performance) AS avg_academic_performance
FROM teen_metrics m
GROUP BY usage_group;


-- 8. Compare mental health indicators across addiction-level groups
DROP VIEW IF EXISTS view_08_metrics_by_addiction;
CREATE VIEW view_08_metrics_by_addiction AS
SELECT 
    CASE 
        WHEN m.addiction_level >= 1 AND m.addiction_level <= 3 THEN 'Low addiction: 1 to 3'
        WHEN m.addiction_level >= 4 AND m.addiction_level <= 7 THEN 'Medium addiction: 4 to 7'
        WHEN m.addiction_level >= 8 AND m.addiction_level <= 10 THEN 'High addiction: 8 to 10'
    END AS addiction_group,
    AVG(m.stress_level) AS avg_stress_level,
    AVG(m.anxiety_level) AS avg_anxiety_level,
    AVG(m.depression_label) AS depression_rate
FROM teen_metrics m
GROUP BY addiction_group;


-- 9. Compare stress and anxiety levels across physical activity groups
DROP VIEW IF EXISTS view_09_metrics_by_activity;
CREATE VIEW view_09_metrics_by_activity AS
SELECT 
    CASE 
        WHEN m.physical_activity < 1 THEN 'Low activity: less than 1'
        WHEN m.physical_activity >= 1 AND m.physical_activity <= 2 THEN 'Medium activity: 1 to 2'
        ELSE 'High activity: more than 2'
    END AS activity_group,
    AVG(m.stress_level) AS avg_stress_level,
    AVG(m.anxiety_level) AS avg_anxiety_level
FROM teen_metrics m
GROUP BY activity_group;


-- 10. Study depression rate across screen-time-before-sleep groups
DROP VIEW IF EXISTS view_10_depression_by_bedtime_screen;
CREATE VIEW view_10_depression_by_bedtime_screen AS
SELECT 
    CASE 
        WHEN m.screen_time_before_sleep < 1 THEN 'Low before sleep: less than 1 hour'
        WHEN m.screen_time_before_sleep >= 1 AND m.screen_time_before_sleep <= 3 THEN 'Medium: 1 to 3 hours'
        ELSE 'High: more than 3 hours'
    END AS screen_time_group,
    AVG(m.depression_label) AS depression_rate
FROM teen_metrics m
GROUP BY screen_time_group;


-- 11. Identify teenagers who match a high-risk profile
DROP VIEW IF EXISTS view_11_high_risk_profile;
CREATE VIEW view_11_high_risk_profile AS
SELECT 
    t.teen_id,
    t.age,
    t.gender,
    m.screen_time_before_sleep,
    m.sleep_hours,
    m.stress_level,
    m.depression_label
FROM teenagers t
JOIN teen_metrics m ON t.teen_id = m.teen_id
WHERE m.screen_time_before_sleep >= 3
  AND m.sleep_hours < 6
  AND m.stress_level >= 7
ORDER BY m.stress_level DESC;


-- 12. Find the top social media users within each platform
DROP VIEW IF EXISTS view_12_top_users_per_platform;
CREATE VIEW view_12_top_users_per_platform AS
WITH ranked_platform_users AS (
    SELECT 
        p.platform_name,
        t.teen_id,
        m.daily_social_media_hours,
        m.academic_performance,
        ROW_NUMBER() OVER (
            PARTITION BY p.platform_id 
            ORDER BY m.daily_social_media_hours DESC
        ) AS platform_rank
    FROM platforms p
    JOIN teen_platforms tp ON p.platform_id = tp.platform_id
    JOIN teenagers t ON tp.teen_id = t.teen_id
    JOIN teen_metrics m ON t.teen_id = m.teen_id
)
SELECT 
    platform_name,
    teen_id,
    daily_social_media_hours,
    academic_performance
FROM ranked_platform_users
WHERE platform_rank <= 5
ORDER BY platform_name, daily_social_media_hours DESC;


-- 13. Compare stress and anxiety levels by platform type
DROP VIEW IF EXISTS view_13_metrics_by_platform_type;
CREATE VIEW view_13_metrics_by_platform_type AS
SELECT 
    p.platform_name, 
    AVG(m.stress_level) AS avg_stress_level,
    AVG(m.anxiety_level) AS avg_anxiety_level
FROM platforms p
JOIN teen_platforms tp ON p.platform_id = tp.platform_id
JOIN teen_metrics m ON tp.teen_id = m.teen_id
GROUP BY p.platform_name;

-- Clean up leftover old views from previous versions
DROP VIEW IF EXISTS view_anxiety_by_usage;
DROP VIEW IF EXISTS view_gender_usage;
DROP VIEW IF EXISTS view_high_risk_teens;
DROP VIEW IF EXISTS view_platform_mental_health;