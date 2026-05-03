# Have correct but minimal imports per file (do not import things you do not use in the file)
from config import get_db_connection

# Have db_utils file and use exception handling

# create a reusable function to excecute query with a parameter to get data from tables
def execute_query(query, params = None):
     with get_db_connection() as connection:
        with connection.cursor(dictionary=True) as cursor:
            cursor.execute(query, params)
            results = cursor.fetchall()
            return results

# Create a function to get all users
def get_all_users():
    users = execute_query("SELECT * FROM users")
    return users


# Create a function to insert a new user
# def insert_user(user_name):
#     with get_db_connection() as connection:
#         with connection.cursor(dictionary=True) as cursor:
#             # insert a new user
#             cursor.execute("""
#                         INSERT INTO users (user_name)
#                         VALUES (%s)
#                         """,
#                         (user_name,)
#                         )
#             #save in database
#             connection.commit()

# Create a function to get user_id
def get_user_id(hf_user_name):
    user_id = execute_query("""
                            SELECT user_id FROM users
                            WHERE user_name = %s
                            """,
                            (hf_user_name,)
                            )
    return user_id

# # Create a function to get all accounts
def get_all_accounts():
    accounts = execute_query("SELECT * FROM accounts")
    return accounts

# Create a function which allows a user to get account information from one parameter 
# to search accounts using either by account_id, a serach term by account_name, by user_id or by created_at
def get_account(hf_account_id=None, hf_search_term=None, hf_user_id=None, hf_created_at=None):
    query = "SELECT * FROM accounts WHERE 1=1"
    params = []

    if hf_account_id:
        query += " AND account_id = %s"
        params.append(hf_account_id)

    if hf_search_term: # users to be able to use a part of the name for the search use comparison operator, LIKE 
        query += " AND account_name LIKE %s"
        like_term = f"%{hf_search_term}%" # like term: %{search_term}% comes afer LIKE and return account name contains search_term
        params.append(like_term) 

    if hf_user_id:
        query += " AND user_id = %s"
        params.append(hf_user_id)

    if hf_created_at: # ##### TODO need to put if date format is not correnct ie not YYYY-MM-DD
        query += " AND created_at = %s"
        params.append(hf_created_at)

    account = execute_query(query, tuple(params))
    return account

# def get_account(hf_account_id=None, hf_search_term=None, hf_user_id=None, hf_created_at=None):
#     with get_db_connection() as connection:
#         with connection.cursor(dictionary=True) as cursor:

#             query = "SELECT * FROM accounts WHERE 1=1"
#             params = []

#             if hf_account_id:
#                 query += " AND account_id = %s"
#                 params.append(hf_account_id)

#             if hf_search_term: # users to be able to use a part of the name for the search use comparison operator, LIKE 
#                 query += " AND account_name LIKE %s"
#                 like_term = f"%{hf_search_term}%" # like term: %{search_term}% comes afer LIKE and return account name contains search_term
#                 params.append(like_term) 

#             if hf_user_id:
#                 query += " AND user_id = %s"
#                 params.append(hf_user_id)

#             if hf_created_at: # ##### TODO need to put if date format is not correnct ie not YYYY-MM-DD
#                 query += " AND created_at = %s"
#                 params.append(hf_created_at)

#             cursor.execute(query, tuple(params))
#             return cursor.fetchall()

# TODO get all transactions


# TODO get/search transactions by prameters

# TODO add transactions

# TODO get transactions and calculate balance



if __name__ == "__main__":
    print(get_all_users())    
    # insert_user('chika')
    # print(get_all_users())
    print(get_user_id('isla'))
    print(get_all_accounts())
    print(get_account(3))



    








# Document how to run your API in a markdown file including editing
# the config file, any installation requirements up until how to run the
# code and what is supposed to happen.
# Submit in GitHub as a Pull Request