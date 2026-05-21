Markdown
# Teenager Mental Health ETL & Analytics Project

A data engineering and analytics project that extracts raw teenager mental health survey data, loads it into a local SQLite database using Python, and normalizes it into a relational schema for advanced SQL analysis. 

The project focuses on building a clean pass-through ETL pipeline, creating an optimized relational schema, and executing targeted analytical queries to study how screen time habits directly affect teenage psychological states and academic performance.

* **Dataset Source:** [Kaggle - Social Media Impact on Teen Mental Health](https://www.kaggle.com/datasets/algozee/teenager-menthal-healy/data)

---

## Project Overview

Raw datasets are often unorganized, nested, or structurally redundant, making direct analysis inefficient. This project handles a real-world data workflow by migrating a flat, unorganized CSV dataset into a balanced 4-table relational database engine.

The database successfully monitors and tracks:
* **Student Demographics:** Age, gender, and profile attributes.
* **Sleep & Screen Habits:** Daily sleep hours vs. device exposure before bed.
* **Academic Performance:** Direct GPA and school tracking metrics.
* **Clinical Health Indicators:** Correlated stress, anxiety, and depression scales.

---

## Main Project Components

### 1. Relational Data Modeling
Converted a flat dataset into a strict 4-table layout to eliminate data redundancy and preserve storage space.
* Established a primary `teenagers` demographics root table.
* Deployed a many-to-many junction bridge (`teen_platforms`) to isolate messy multi-app text entries into atomic rows.
* Balanced a 1-to-1 operational metric store (`teen_metrics`) for clinical and academic variables.

### 2. Python ETL Pipeline
Implemented a modular data engineering workflow using Python and SQLAlchemy:
* `extract.py`: Reads the raw source CSV dataset using Pandas directly into memory.
* `transform.py`: Functions as a clean pass-through layer to guarantee raw data integrity prior to ingestion.
* `load.py`: Automatically creates the engine and loads data blocks into a local SQLite instance.
* `main.py`: Coordinates and executes the entire data pipeline instantly.

### 3. SQL Analytics
Executed advanced data analysis directly inside the database engine using SQL queries to extract behavioral and clinical trends:
* Used **Common Table Expressions (CTEs)** and advanced **Window Functions** (`ROW_NUMBER()`) to partition application user spaces and isolate the top 5 heaviest screen consumers on each platform.
* Applied conditional array grouping (`CASE WHEN`) to segment screen time into Low, Medium, and High usage brackets to find exact anxiety breaking points.
* Implemented multi-table `JOIN` operations and filter logic to capture high-risk, sleep-deprived target profiles.

---

## Technologies Used

* **Language:** Python
* **Libraries:** Pandas, SQLAlchemy
* **Database Engine:** SQLite
* **Query Language:** SQL
* **Version Control:** Git & GitHub

---

## Project Structure

```bash
project/
│
├── data/
│   └── Teen_Mental_Health_Dataset.csv
│
├── app/
│   ├── extract.py
│   ├── transform.py
│   ├── load.py
│   └── main.py
│
├── sql/
│   ├── 02_create_schema.sql
│   ├── 03_insert_data.sql
│   └── teen_platform_usage.sql
│
└── README.md
