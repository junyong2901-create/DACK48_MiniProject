import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

load_dotenv()

DB_HOST = os.getenv('DB_HOST')
DB_PORT = os.getenv('DB_PORT')
DB_USER = os.getenv('DB_USER')
DB_PASS = os.getenv('DB_PASS')
DB_NAME = os.getenv('DB_NAME')

sales = pd.read_csv(r"C:\Users\dungt\Documents\DA\Python\DAC Python\Sales Transaction.csv")

sales['ingestion_timestamp'] = pd.Timestamp.now()

print(sales.head())

try:
    engine = create_engine(f'postgresql+psycopg2://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}')
    print("Created engine successfully")
except Exception as e:
    print(f"Error creating engine: {e}")
    exit(1)

try: 
    sales.to_sql(
        name = "Raw_Sales",
        con = engine,
        schema = "bronze",
        if_exists = "append"
    )
    print("Raw Sales inserted successfully")
except Exception as e:
    print(f"Error inserting Raw Sales: {e}")
    exit(1)