# Have correct but minimal imports per file (do not import things you do not use in the file)
import requests
requests.get("http://127.0.0.1:5000").text

# Implement client-side for each of the 3 API endpoints you have created.

# get all users from the endpoint for users
response = requests.get("http://127.0.0.1:5000/users")
if response.status_code == 200:
    users = response.json()
    for user in users:
        print(user)
else:
    print(f"Failed to retrieve users. Status code: {response.status_code}")

# get request to get all the accounts
response = requests.get("http://127.0.0.1:5000/accounts")
if response.status_code == 200:
    accounts = response.json()
    for account in accounts:
        print(account)
else:
    print(f"Failed to retrieve users. Status code: {response.status_code}")

# get request to get all the transactions
response = requests.get("http://127.0.0.1:5000/transactions")
if response.status_code == 200:
    transactions = response.json()
    for transaction in transactions:
        print(transaction)
else:
    print(f"Failed to retrieve users. Status code: {response.status_code}")

# get request to get an account information with user_id as an unique identifier
user_id = 3
response = requests.get(f"http://127.0.0.1:5000/accounts/{user_id}")
if response.status_code == 200:
    accounts_by_id = response.json()
    for account_by_id in accounts_by_id:
        print(account_by_id)
else:
    print(f"Failed to retrieve users. Status code: {response.status_code}")


# get request to get a transaction inforamtion with account_id as an unique identifier
account_id = 4
response = requests.get(f"http://127.0.0.1:5000/transactions/{account_id}")
if response.status_code == 200:
    transactions_by_account_id = response.json()
    for transaction in transactions_by_account_id:
        print(transaction)
else:
    print(f"Failed to retrieve users. Status code: {response.status_code}")

# get request to get balance of each account
response = requests.get("http://127.0.0.1:5000/balance")
if response.status_code == 200:
    balance = response.json()
    for b in balance:
        print(b)
else:
    print(f"Failed to retrieve users. Status code: {response.status_code}")

# add a new user
new_user = {"user_name" : "paul2"}
response = requests.post("http://127.0.0.1:5000/users", json=new_user)
if response.status_code == 201:
    print("New user added successfully.")
else:
    print(f"Failed to add users. Status code: {response.status_code}")

# add a new transaction
new_transaction = {
    "account_id" : 5,
    "amount": 4.00,
    "transaction_type" : "allowance",
    "description" : "weekly allowance",
    "transaction_date" : "2026-05-03"
}
response = requests.post("http://127.0.0.1:5000/transactions", json=new_transaction)
if response.status_code == 201:
    print("New transaction added succesfully.")
else:
    print(f"Failed to add transaction. Status code: {response.status_code}")


# In main.py have a run() function/call the functions to simulate the
# planned interaction with the API, this could include welcome
# statements, displaying etc., (hairdressers booking example from
# lesson)

# add readme file
