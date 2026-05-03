# Have correct but minimal imports per file (do not import things you do not use in the file)
from flask import Flask, request, jsonify
from db_utils import get_all_users, get_all_accounts, get_all_transactions, get_account, get_transactions_by_params, get_account_balance, insert_user, insert_account, insert_transaction, delete_account

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
    all_users = get_all_users()
    return jsonify(all_users)

# get request to get all the accounts
@app.route('/accounts', methods = ['GET'])
def accounts():
    all_accounts = get_all_accounts()
    return jsonify(all_accounts)

# get request to get an account information with id as an unique identifier
@app.route('/accounts/<int:user_id>', methods = ['GET'])
def get_account_by_user_id(user_id):
    account_by_user_id = get_account(p_user_id = user_id)
    return jsonify(account_by_user_id)

# get request to get all the transactions
@app.route('/transactions', methods = ['GET'])
def transactions():
    all_transactions =  get_all_transactions()
    return jsonify(all_transactions)

# get request to get a transaction inforamtion with account_id as an unique identifier
@app.route('/transactions/<int:account_id>', methods = ['GET'])
def get_transactions_by_account_id(account_id):
    transactions_by_account_id = get_transactions_by_params(p_account_id = account_id)
    return jsonify(transactions_by_account_id)

# get request to get balance of each account
@app.route('/balance', methods = ['GET'])
def balance():
    account_balance = get_account_balance()
    return jsonify(account_balance)

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
    data = request.get_json()
    name = data['user_name']
    if is_user_exist(name):
        return "User already exists."
    else: 
        insert_user(name)
        return jsonify({"message": "New user added succesfully"}), 201

# add a new account
@app.route('/accounts', methods = ['POST'])
def add_account():
    data = request.get_json()
    insert_account(
        p_account_name = data.get('account_name'),
        p_user_id = data.get('user_id'),
        p_created_at = data.get('created_at')
    )
    return jsonify({"message": "New account added succesfully"}), 201

# add a new transaction
@app.route('/transactions', methods = ['POST'])
def add_transaction():
    data = request.get_json()
    insert_transaction(
        account_id = data.get('account_id'),
        amount = data.get('amount'),
        transaction_type = data.get('transaction_type'),
        description = data.get('description'),
        transaction_date = data.get('transaction_date')
    )
    return jsonify({"message": "Transaction added succesfully"}), 201

if __name__ == '__main__':
    app.run(debug=True)

