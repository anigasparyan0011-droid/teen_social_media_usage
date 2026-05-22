from pathlib import Path
from sqlalchemy import create_engine


def load_data(dfs):
    project_root = Path(__file__).resolve().parent.parent
    db_path = project_root / "teen_mental_health.db"

    engine = create_engine(f"sqlite:///{db_path}")

    for table_name, df in dfs.items():
        df.to_sql(
            table_name,
            engine,
            if_exists="replace",
            index=False
        )

        print(f"{table_name} loaded.")

    for table_name, df in dfs.items():
        df.to_sql(table_name, engine, if_exists="replace", index=False)
        print(f"{table_name} loaded.")
        
    return engine 