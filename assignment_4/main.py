# Have correct but minimal imports per file (do not import things you do not use in the file)
import requests

# In main.py have a run() function/call the functions to simulate the
# planned interaction with the API, this could include welcome
# statements, displaying etc., (hairdressers booking example from
# lesson)

def run():
    # Display homepage
    print("** Home pagen **")    # Print to display what inforamtion is called.
    print(requests.get("http://127.0.0.1:5000").text)
    print()     # give a blank space to have a break from each API call

    # Implement client-side for each of the 3 API endpoints you have created.
    max_user_id = 0 # to find out the new user's id when creating a new account for a new user
    # get all users from the endpoint for users
    print("** Retrieving all users **") # Print to display what inforamtion is called.
    response = requests.get("http://127.0.0.1:5000/users")
    if response.status_code == 200:
        users = response.json()
        for user in users:
            print(user) # this is to show the call response
            if user['user_id'] > max_user_id: # this part is to find out max_user_id
                max_user_id = user['user_id']

    else:
        print(f"Failed to retrieve users. Status code: {response.status_code}")
    print()

    # get request to get all the accounts
    print("** Retrieving all accounts **")  
    response = requests.get("http://127.0.0.1:5000/accounts")
    if response.status_code == 200:
        accounts = response.json()
        for account in accounts:
            print(account)
    else:
        print(f"Failed to retrieve users. Status code: {response.status_code}")
    print() 

    # get request to get all the transactions
    print("** Retrieving all transactions **")
    response = requests.get("http://127.0.0.1:5000/transactions")
    if response.status_code == 200:
        transactions = response.json()
        for transaction in transactions:
            print(transaction)
    else:
        print(f"Failed to retrieve users. Status code: {response.status_code}")
    print()

    # get request to get an account information with user_id as an unique identifier
    print("** Retrieving user_id = 3 account information **")
    user_id = 3
    response = requests.get(f"http://127.0.0.1:5000/accounts/{user_id}")
    if response.status_code == 200:
        accounts_by_id = response.json()
        for account_by_id in accounts_by_id:
            print(account_by_id)
    else:
        print(f"Failed to retrieve users. Status code: {response.status_code}")
    print()

    # get request to get a transaction inforamtion with account_id as an unique identifier
    print("** Retrieving account_id = 1 account information **")
    account_id = 1
    response = requests.get(f"http://127.0.0.1:5000/transactions/{account_id}")
    if response.status_code == 200:
        transactions_by_account_id = response.json()
        for transaction in transactions_by_account_id:
            print(transaction)
    else:
        print(f"Failed to retrieve users. Status code: {response.status_code}")
    print()

    # get request to get balance of each account
    print("** Retrieving balance for each account **")
    response = requests.get("http://127.0.0.1:5000/balance")
    if response.status_code == 200:
        balance = response.json()
        for b in balance:
            print(b)
    else:
        print(f"Failed to retrieve users. Status code: {response.status_code}")
    print()

    # add a new user
    print("** Adding a new user **")
    new_user = {"user_name" : "chika3"}
    response = requests.post("http://127.0.0.1:5000/users", json=new_user)
    if response.status_code == 201:
        print(f"New user added successfully. New user ID: {max_user_id}")
    else:
        print(f"Failed to add users. Status code: {response.status_code}")
    print()

    # add a new account for a new user
    print("** Adding a new account **")
    new_account = {
        "account_name": "chika3 account",
        "user_id": max_user_id,
        "created_at":"2026-05-03"
    }
    response = requests.post("http://127.0.0.1:5000/accounts", json=new_account)
    if response.status_code == 201:
        print("New account added successfully.")
    else:
        print(f"Failed to add users. Status code: {response.status_code}")
    print()

    # add a new transaction
    print("** Adding a new transaction **")
    new_transaction = {
        "account_id" : 6,
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


# add readme file
run()