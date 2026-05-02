# Have correct but minimal imports per file (do not import things you do not use in the file)
from flask import Flask, request, jsonify
from db_utils import get_all_users, insert_user, get_all_accounts, search_accounts # TODO add more functions after created

app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to the Pocket Money Management API! You can manage your children's pocket money and analyse transactions."

# Implement 2 API endpoints with appropriate functionality
# get request to get all users
@app.route('/users', methods = ['GET'])
def users():
    users = get_all_users
    return jsonify(users)

# add a new user
@app.route('/users', methods = ['POST'])
def add_user():
    data = request.get_json()
    insert_user(
        user_name = data.get('user_name')
    )
    return jsonify({"message": "New user added succesfully"}), 201
    


# get request to get all the accounts
@app.route('/accounts', methods = ['GET'])
def accounts():
    accounts = get_all_accounts()
    return jsonify(accounts)

# get request to search accounts information with id as an unique identifier
@app.route('/account/<int:user_id>', methods = ['GET'])
def get_account_by_user_id(user_id):
    get_account_by_user_id = search_accounts(hf_user_id=user_id)
    return jsonify(get_account_by_user_id)


# def find_account(account_id = None, serch_term = None, user_id = None, created_at = None):
#     if account_id:
#         account_by_account_id = search_accounts(account_id)
#         return jsonify(account_by_account_id)
#     elif serch_term:
#         account_by_serch_term = search_accounts(serch_term)
#         return jsonify(account_by_serch_term)
#     elif user_id:
#         account_by_user_id = search_accounts(user_id)
#         return jsonify(account_by_user_id)
#     else:
#         account_by_created_at = search_accounts(created_at)
#         return jsonify(account_by_created_at)


# Implement one additional endpoint of your choice (can be POST or
# GET but with a different implementation)

# Use appropriate SQL queries to interact with the database in your
# Flask application, and demonstrate at least two different queries.


if __name__ == '__main__':
    app.run(debug=True)

