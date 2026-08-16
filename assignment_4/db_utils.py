# Have correct but minimal imports per file (do not import things you do not use in the file)
from config import get_db_connection

# Have db_utils file and use exception handling

# To get information
# create a reusable function to excecute query with a parameter to get data from tables
def execute_query(query, params = None):
    try:
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute(query, params)
                results = cursor.fetchall()
                return results
            
    except connection.Error as err:
        print(f"Something went wrong: {err}")
        return None

# Create a function to get all users
def get_all_users():
    users = execute_query("SELECT * FROM users")
    return users

# Create a function to get user_id
def get_user_id(p_user_name):
    user_id = execute_query("""
                            SELECT user_id FROM users
                            WHERE user_name = %s
                            """,
                            (p_user_name,)
                            )
    return user_id

# # Create a function to get all accounts
def get_all_accounts():
    accounts = execute_query("SELECT * FROM accounts")
    return accounts

# Create a function which allows a user to get account information from one parameter 
# to search accounts using either by account_id, a serach term by account_name, by user_id or by created_at
def get_account(p_account_id=None, p_search_term=None, p_user_id=None, p_created_at=None):
    query = "SELECT * FROM accounts WHERE 1=1"
    params = []

    if p_account_id:
        query += " AND account_id = %s"
        params.append(p_account_id)

    if p_search_term: # users to be able to use a part of the name for the search use comparison operator, LIKE 
        query += " AND account_name LIKE %s"
        like_term = f"%{p_search_term}%" # like term: %{search_term}% comes afer LIKE and return account name contains search_term
        params.append(like_term) 

    if p_user_id:
        query += " AND user_id = %s"
        params.append(p_user_id)

    if p_created_at: 
        query += " AND created_at = %s"
        params.append(p_created_at)

    account = execute_query(query, tuple(params))
    return account

# Create a function to get all transactions
def get_all_transactions():
    transactions = execute_query("SELECT * FROM transactions")
    return transactions

# Create a function to get transaction by account_id or transaction_type_id
def get_transactions_by_params(p_account_id = None, p_transaction_type_id = None):
    query = "SELECT * FROM transactions WHERE 1=1"
    params = []

    if p_account_id:
        query += " AND account_id = %s"
        params.append(p_account_id)

    elif p_transaction_type_id:
        query += " AND transaction_type_id = %s"
        params.append(p_transaction_type_id)
    
    transactions = execute_query(query, tuple(params))
    return transactions

# Create a function to calculate balance of each account 
def get_account_balance():
    balance = execute_query("""
                            SELECT 
                            account_id,
                            SUM(amount) AS balance
                            FROM transactions
                            GROUP BY account_id
                            """)
    return balance


# To insert data
# Create a function to insert a new user
def insert_user(p_user_name):
    try:
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute("""
                            INSERT INTO users (user_name)
                            VALUES (%s)
                            """,
                            (p_user_name,)
                )
                connection.commit()
                last_id = cursor.lastrowid
                print("New user ID:", last_id)
    except connection.Error as err:
        print(f"Insertion error: {err}")
        return None

# Create a function to insert a new account
def insert_account(p_account_name, p_user_id, p_created_at):
    try:
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute("""
                               INSERT INTO accounts (account_name, user_id, created_at)
                               VALUES (%s, %s, %s)
                               """,
                               (p_account_name, p_user_id, p_created_at)
                )
                connection.commit()
                last_id = cursor.lastrowid
                print("New account ID:", last_id)
    except connection.Error as err:
        print(f"Insertion error: {err}")
        return None
        
# Create a function to insert a new transaction
def insert_transaction(account_id, amount, transaction_type, description, transaction_date):
    try:
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                args = (account_id, amount, transaction_type, description, transaction_date)
                cursor.callproc('InsertTransactionValues', args)
                connection.commit()
    except connection.Error as err:
        print(f"Insertion error: {err}")
        return None

# Create a function to delete an account with account_id and user_id
def delete_account(p_account_id, p_user_id):
    try:
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute("SET FOREIGN_KEY_CHECKS = 0")
                cursor.execute("""
                            DELETE FROM accounts
                            WHERE account_id = %s AND user_id = %s
                            """,
                            (p_account_id, p_user_id)
                            )
                cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
                connection.commit()
    except connection.Error as err:
        print(f"Deletion error: {err}")
        return None

# Create a function to delete an user with user_id
def delete_user(p_user_id):
    try:
        with get_db_connection() as connection:
            with connection.cursor(dictionary=True) as cursor:
                cursor.execute("SET FOREIGN_KEY_CHECKS = 0")
                cursor.execute("""
                               DELETE FROM users
                               WHERE user_id = %s
                               """,
                               (p_user_id,)
                )
                cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
                connection.commit()
    except connection.Error as err:
        print(f"Deletion error: {err}")
        return None


if __name__ == "__main__":
    # for testing.
    print(get_all_users())    
