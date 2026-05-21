PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS teen_platforms;
DROP TABLE IF EXISTS teen_metrics;
DROP TABLE IF EXISTS platforms;
DROP TABLE IF EXISTS teenagers;

CREATE TABLE teenagers (
    teen_id INTEGER PRIMARY KEY,
    age INTEGER NOT NULL,
    gender TEXT NOT NULL,

    CHECK (age BETWEEN 13 AND 19),
    CHECK (gender IN ('male', 'female'))
);

CREATE TABLE platforms (
    platform_id INTEGER PRIMARY KEY,
    platform_name TEXT NOT NULL UNIQUE
);

CREATE TABLE teen_platforms (
    teen_id INTEGER NOT NULL,
    platform_id INTEGER NOT NULL,

    PRIMARY KEY (teen_id, platform_id),

    FOREIGN KEY (teen_id)
        REFERENCES teenagers(teen_id),

    FOREIGN KEY (platform_id)
        REFERENCES platforms(platform_id)
);

CREATE TABLE teen_metrics (
    teen_id INTEGER PRIMARY KEY,

    daily_social_media_hours REAL NOT NULL,
    sleep_hours REAL NOT NULL,
    screen_time_before_sleep REAL NOT NULL,
    academic_performance REAL NOT NULL,
    physical_activity REAL NOT NULL,
    social_interaction_level TEXT NOT NULL,

    stress_level INTEGER NOT NULL,
    anxiety_level INTEGER NOT NULL,
    addiction_level INTEGER NOT NULL,
    depression_label INTEGER NOT NULL,

    CHECK (social_interaction_level IN ('low', 'medium', 'high')),
    CHECK (stress_level BETWEEN 1 AND 10),
    CHECK (anxiety_level BETWEEN 1 AND 10),
    CHECK (addiction_level BETWEEN 1 AND 10),
    CHECK (depression_label IN (0, 1)),

    FOREIGN KEY (teen_id)
        REFERENCES teenagers(teen_id)
);