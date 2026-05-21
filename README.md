# Teenager Mental Health ETL & Analytics Project

An end-to-end data engineering and analytics project that extracts raw teenager mental health survey data, cleans and normalizes it using Python into a local relational SQLite database, and executes targeted analytical queries to study how screen time habits affect teenage psychological states and academic performance.

**Dataset Source:** Kaggle - Social Media Impact on Teen Mental Health

---

## Project Overview
Raw datasets are often unorganized, nested, or structurally redundant, making direct analysis inefficient. This project handles a real-world data workflow by migrating a flat, unorganized CSV dataset into an optimized, balanced 4-table relational database engine. 

The database successfully monitors and tracks:
* **Student Demographics:** Age, gender, and profile attributes.
* **Sleep & Screen Habits:** Daily sleep hours vs. device exposure before bed.
* **Academic Performance:** Direct GPA and school tracking metrics.
* **Clinical Health Indicators:** Correlated stress, anxiety, and depression scales.

---

## Dataset & Schema Description
The database converts a flat dataset into a strict 4-table layout to eliminate data redundancy, enforce data integrity, and preserve storage space.

| Table Name | Description | Key Fields Included |
| :--- | :--- | :--- |
| **teenagers** | Core demographic roots | `teen_id`, `age`, `gender` |
| **platforms** | Unique social media tracking directory | `platform_id`, `platform_name` |
| **teen_platforms** | Many-to-many junction bridge mapping multi-app use | `teen_id`, `platform_id` |
| **teen_metrics** | 1-to-1 operational store for clinical/academic data | `daily_social_media_hours`, `sleep_hours`, `stress_level`, `anxiety_level`, `depression_label` |

---

## Explanation of Data Cleaning & Preprocessing
To ensure strict relational integrity and accurate analytics, the pipeline automates the following cleaning and transformation steps during the ETL process:

1. **Text Standardization:** Applied `LOWER(TRIM(column))` functions to categorical text blocks like `gender` and `social_interaction_level` to eliminate trailing whitespace and mismatching case issues (e.g., converting mixed string formats into a uniform record).
2. **Junction Table Normalization:** Resolved instances where data rows contained combined values (like `'Both'` under platform usage). The staging logic extracts these rows and inserts separate relational mappings for both 'Instagram' and 'TikTok' linked back to the specific user ID.
3. **Foreign Key Integrity:** Configured active `PRAGMA foreign_keys = ON;` constraints alongside structural cascading mechanisms (`ON DELETE CASCADE`) to prevent orphaned logs or mismatched data links.

---

## Main Project Components

### 1. Python ETL Pipeline (`app/`)
Implemented a modular data engineering workflow using Python and SQLAlchemy:
* **`extract.py`**: Reads the raw source CSV dataset using Pandas directly into memory.
* **`transform.py`**: Functions as a clean pass-through layer to guarantee raw data integrity prior to ingestion.
* **`load.py`**: Automatically creates the engine and loads data blocks into a local SQLite instance.
* **`main.py`**: Coordinates and executes the entire data pipeline instantly.

### 2. SQL Analytics (`sql/`)
Executed advanced data analysis directly inside the database engine using SQL queries to extract behavioral and clinical trends:
* Used **Common Table Expressions (CTEs)** and advanced **Window Functions (`ROW_NUMBER()`)** to partition application user spaces and isolate the top 5 heaviest screen consumers on each platform.
* Applied **conditional grouping (`CASE WHEN`)** to segment screen time into Low, Medium, and High usage brackets to find exact anxiety breaking points.
* Implemented multi-table **JOIN operations** and filter logic to capture high-risk, sleep-deprived target profiles.

---

## Technologies Used
* **Language:** Python
* **Libraries:** Pandas, SQLAlchemy
* **Database Engine:** SQLite
* **Query Language:** SQL
* **Version Control:** Git & GitHub

---

## Project Structure
```text
project/
├── app/
│   ├── extract.py
│   ├── transform.py
│   ├── load.py
│   └── main.py
├── data/
│   └── Teen_Mental_Health_Dataset.csv
├── sql/
│   ├── schema.sql
│   └── queries.sql
├── README.md
└── requirements.txt
