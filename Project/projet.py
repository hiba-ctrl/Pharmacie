import psycopg2
import pandas as pd
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

def connect_to_database():
    # Database connection parameters
    dbname = 'Pharmacie'
    user = 'hiba'
    password = 'pharma'
    host = 'localhost'  # Update if your database is hosted elsewhere

    try:
        # Connect to your database
        conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host)
        
        # Set the isolation level to AUTOCOMMIT
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        
        print("Connection established.")
        return conn
    except psycopg2.Error as e:
        print(f"An error occurred: {e}")
        return None

def fetch_data(conn):
    cursor = conn.cursor()
 
    try:
        cursor.execute("SELECT * FROM produit")
        rows = cursor.fetchall()
        return rows  # Return the fetched rows
    except psycopg2.Error as e:
        print(f"An error occurred: {e}")
        return []  # Return an empty list in case of error
    finally:
        cursor.close()

def main():
    # Connect to the database
    conn = connect_to_database()

    if conn is not None:
        # Fetch data from the database
        rows = fetch_data(conn)  # Capture the returned rows
        
        # Create DataFrame and display it
        columns = ['ID', 'Fournisseur', 'Categorie', 'Nom', 'Prix Vente', 'Prix Achat', 'Date Expr.']
        df = pd.DataFrame(rows, columns=columns)
        print(df)
        
        # Close the connection
        conn.close()
        print("Connection closed.")

if __name__ == "__main__":
    main()
