# Teenager Mental Health ETL & Analytics Project

A data engineering and analytics project that extracts, cleans, transforms, and loads teenager mental health survey data into a relational SQL database using Python and Pandas.

The project focuses on building a simple ETL pipeline, designing a normalized database schema, and performing SQL analysis on real-world mental health data.

Dataset Source:
https://www.kaggle.com/datasets/algozee/teenager-menthal-healy/data

---

# Project Overview

Raw datasets are often inconsistent, duplicated, or incomplete, making them difficult to analyze directly.
This project simulates a real-world data workflow by processing teenager mental health survey data and transforming it into a structured relational database for analytics.

The dataset includes information related to:

* Student demographics
* Sleep habits
* Academic pressure
* Social media usage
* Stress and anxiety indicators
* Mental health conditions

---

# Main Project Components

## Data Modeling

Designed a relational database schema with:

* Multiple related tables
* Primary and foreign keys
* Constraints and relationships
* Normalized structure to reduce redundancy

---

## Data Cleaning & Transformation

Performed preprocessing steps including:

* Handling missing values
* Removing duplicates
* Standardizing formats
* Fixing incorrect data types
* Validating relationships between tables

---

## ETL Pipeline

Implemented a modular ETL workflow using Python:

* extract.py → Reads raw dataset files
* transform.py → Cleans and preprocesses the data
* load.py → Inserts processed data into SQL database
* main.py → Runs the complete pipeline

---

# SQL Analysis

Using SQL queries, the project explores questions such as:

* Does low sleep duration correlate with higher stress?
* How does social media usage affect mental health?
* Which student groups show higher anxiety levels?
* Are there differences between genders?
* What lifestyle patterns are linked to healthier mental conditions?

The analysis includes:

* JOINs
* GROUP BY
* Aggregate functions
* Filtering
* Window functions

---

# Technologies Used

* Python
* Pandas
* NumPy
* PostgreSQL / MySQL / SQL Server
* SQL
* Git & GitHub

---

# Project Structure

bash id="53f5lv"
project/
│
├── data/
│   └── teenager_mental_health.csv
│
├── app/
│   ├── extract.py
│   ├── transform.py
│   ├── load.py
│   └── main.py
│
├── sql/
│   ├── schema.sql
│   └── queries.sql
│
├── requirements.txt
└── README.md

---

# How To Run The Project

## 1. Clone Repository

bash id="vwj08o"
git clone https://github.com/your-username/teenager-mental-health-project.git
cd teenager-mental-health-project

---

## 2. Install Dependencies

bash id="wz0b6s"
pip install -r requirements.txt

---

## 3. Configure Database Settings

Update database credentials inside load.py.

---

## 4. Create Database Schema

Run:

bash id="6d9jol"
sql/schema.sql

---

## 5. Execute ETL Pipeline

bash id="iqqfzm"
python app/main.py

---

## 6. Run SQL Queries

Execute:

bash id="czt7ub"
sql/queries.sql

to generate analytical results.

---

# Key Learning Outcomes

This project demonstrates:

* ETL pipeline development
* Relational database design
* Data cleaning and preprocessing
* SQL analytics and reporting
* Working with real-world datasets

---

# License

Kaggle (https://www.kaggle.com/datasets/algozee/teenager-menthal-healy/data)
Social Media Impact on Teen Mental Health
Analyzing how social media affects stress, anxiety, and sleep
