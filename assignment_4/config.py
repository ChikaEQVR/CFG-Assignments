# Have a config file (do not leave your private information here)
# Have correct but minimal imports per file (do not import things you do not use in the file)
import mysql.connector as connector
import os
from dotenv import load_dotenv
load_dotenv("./.env", override=True)  # my .env file is in the same folder so path = "./.env"
#Load environment variables from .env file


def get_db_connection():    
    return connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )
