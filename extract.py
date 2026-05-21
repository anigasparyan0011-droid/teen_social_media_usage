import pandas as pd
from pathlib import Path


def extract_data():
    project_root = Path(__file__).resolve().parent.parent
    csv_path = project_root / "data" / "Teen_Mental_Health_Dataset.csv"

    df = pd.read_csv(csv_path)

    return {
        "teen_mental_health_raw": df
        
    }