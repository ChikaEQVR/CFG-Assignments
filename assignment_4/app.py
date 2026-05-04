# Have correct but minimal imports per file (do not import things you do not use in the file)
from flask import Flask, request, jsonify
from db_utils import get_all_users, get_all_accounts, get_all_transactions, get_account, get_transactions_by_params, get_account_balance, insert_user, insert_account, insert_transaction

# To start Flask app
app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to the Pocket Money Management API! You can manage your children's pocket money and analyse transactions."

# Implement 2 API endpoints with appropriate functionality
# Use appropriate SQL queries to interact with the database in your
# Flask application, and demonstrate at least two different queries.

# get request to get all users
@app.route('/users', methods = ['GET'])
def users():
    try:
        # get_all_users returns None if there is an exception.
        all_users = get_all_users()

        if all_users is not None:
            return jsonify(all_users)
        elif all_users is None:
            return "something went wrong and could not retrieve data"
        
    # exception handler for errors outside get_all_users
    except Exception as e:
        return f"something went wrong {e}"

# get request to get all the accounts
@app.route('/accounts', methods = ['GET'])
def accounts():
    try:
        all_accounts = get_all_accounts()

        if all_accounts is not None:
            return jsonify(all_accounts)
        elif all_accounts is None:
            return "something went wrong and could not retrieve data"
        
    except Exception as e:
        return f"something went wrong {e}"
    
# get request to get an account information with id as an unique identifier
@app.route('/accounts/<int:user_id>', methods = ['GET'])
def get_account_by_user_id(user_id):
    try:
        account_by_user_id = get_account(p_user_id = user_id)

        if account_by_user_id is not None:
            return jsonify(account_by_user_id)
        elif account_by_user_id is None:
            return "something went wrong and could not retrieve data"
        
    except Exception as e:
        return f"something went wrong {e}"

# get request to get all the transactions
@app.route('/transactions', methods = ['GET'])
def transactions():
    try:
        all_transactions =  get_all_transactions()

        if all_transactions is not None:
            return jsonify(all_transactions)
        elif all_transactions is None:
            return "something went wrong and could not retrieve data"
    
    except Exception as e:
        return f"something went wrong {e}"

# get request to get a transaction inforamtion with account_id as an unique identifier
@app.route('/transactions/<int:account_id>', methods = ['GET'])
def get_transactions_by_account_id(account_id):
    try:
        transactions_by_account_id = get_transactions_by_params(p_account_id = account_id)

        if transactions_by_account_id is not None:
            return jsonify(transactions_by_account_id)
        elif transactions_by_account_id is None:
            return "something went wrong and could not retrieve data"
    
    except Exception as e:
        return f"something went wrong {e}"    

# get request to get balance of each account
@app.route('/balance', methods = ['GET'])
def balance():
    try:
        account_balance = get_account_balance()

        if account_balance is not None:
            return jsonify(account_balance)
        elif account_balance is None:
            return "something went wrong and could not retrieve data"
        
    except Exception as e:
        return f"something went wrong {e}"

# Implement one additional endpoint of your choice (can be POST or
# GET but with a different implementation)

# create a function to check if a user exists or not
def is_user_exist(name):
    users = get_all_users() # returns list of dictionary
    for user_dict in users:
        if user_dict["user_name"] == name:
            return True
    return False
    
# add a new user if not exist # Not allowing the duplication here as usually children's names are different in a family.
@app.route('/users', methods = ['POST'])
def add_user():
    try:
        data = request.get_json()
        name = data['user_name']
        if is_user_exist(name):
            return "User already exists."
        else: 
            insert_user(name)
            return jsonify({"message": "New user added succesfully"}), 201
    
    except Exception as e:
        return f"something went wrong {e}"

# add a new account
@app.route('/accounts', methods = ['POST'])
def add_account():
    try:
        data = request.get_json()
        insert_account(
            p_account_name = data.get('account_name'),
            p_user_id = data.get('user_id'),
            p_created_at = data.get('created_at')
        )
        return jsonify({"message": "New account added succesfully"}), 201
    
    except Exception as e:
        return f"something went wrong {e}"

# add a new transaction
@app.route('/transactions', methods = ['POST'])
def add_transaction():
    try:
        data = request.get_json()
        insert_transaction(
            account_id = data.get('account_id'),
            amount = data.get('amount'),
            transaction_type = data.get('transaction_type'),
            description = data.get('description'),
            transaction_date = data.get('transaction_date')
        )
        return jsonify({"message": "Transaction added succesfully"}), 201
    
    except Exception as e:
        return f"something went wrong {e}"

if __name__ == '__main__':
    app.run(debug=True)

