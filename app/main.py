from pathlib import Path
from extract import extract_data
from transform import transform_data
from load import load_data
from sqlalchemy import text 

def run_sql_file(file_path, engine_connection):
    """Reads a .sql file, splits it by semicolons, and executes statements one-by-one."""
    if not file_path.exists():
        print(f"Warning: Could not find script at {file_path}")
        return
    print(f"Executing script: {file_path.name}...")
    
    with open(file_path, "r", encoding="utf-8") as f:
        sql_content = f.read()
    queries = [q.strip() for q in sql_content.split(";") if q.strip()]
    with engine_connection.connect() as connection:
        connection.execute(text("PRAGMA foreign_keys = ON;"))
        for query in queries:
            connection.execute(text(query))
        connection.commit()

def run_pipeline():
    raw_data = extract_data()
    transformed_data = transform_data(raw_data)
    engine = load_data(transformed_data)
    print("Creating 'raw_with_id' table...")
    with engine.connect() as connection:
        connection.execute(text("DROP TABLE IF EXISTS raw_with_id;"))
        connection.execute(text("""
            CREATE TABLE raw_with_id AS
            SELECT rowid AS teen_id, teen_mental_health_raw.* FROM teen_mental_health_raw;
        """))
        connection.commit()
    python_folder = Path(__file__).resolve().parent
    project_root = python_folder.parent
    sql_folder = project_root / "sql"
   
    run_sql_file(sql_folder / "schema.sql", engine)
    run_sql_file(sql_folder / "queries.sql", engine)    
    print("Pipeline fully complete! All relational tables created and populated.")

if __name__ == "__main__":
    run_pipeline()