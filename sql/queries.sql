-- 1. Compare average daily social media usage by gender
SELECT 
    t.gender,
    COUNT(t.teen_id) AS total_teenagers,
    AVG(tm.daily_social_media_hours) AS avg_daily_social_media_hours
FROM teenagers t
JOIN teen_metrics tm ON t.teen_id = tm.teen_id
GROUP BY t.gender;


-- 2. Compare platform user counts after normalization
SELECT 
    p.platform_name,
    COUNT(tp.teen_id) AS total_user_count
FROM platforms p
JOIN teen_platforms tp ON p.platform_id = tp.platform_id
GROUP BY p.platform_name;


-- 3. Compare average stress level by platform
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
SELECT 
    p.platform_name,
    COUNT(tp.teen_id) AS total_users,
    AVG(m.depression_label) AS depression_rate
FROM platforms p
JOIN teen_platforms tp ON p.platform_id = tp.platform_id
JOIN teen_metrics m ON tp.teen_id = m.teen_id
GROUP BY p.platform_name;


-- 5. Study anxiety level across daily social media usage groups
SELECT 
    CASE 
        WHEN m.daily_social_media_hours < 2 THEN 'Low usage. Less than 2 hours'
        WHEN m.daily_social_media_hours >= 2 AND m.daily_social_media_hours <= 5 THEN 'Medium usage. 2 to 5 hours'
        ELSE 'High usage. More than 5 hours'
    END AS usage_group,
    AVG(m.anxiety_level) AS avg_anxiety_level
FROM teen_metrics m
GROUP BY usage_group
ORDER BY m.daily_social_media_hours ASC;


-- 6. Identify teenagers who match a high-risk profile
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


-- 7. Find the top social media users within each platform
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
