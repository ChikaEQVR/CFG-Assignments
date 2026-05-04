### Assignment 4 ###  

I created Pocket Money Manager AIP to manage my children't pocket money and analyse the transactions.  

#### To set up DB:  
1. Please use 'pocketmoney_db.sql' to create the database and insert some data into tables.  

#### To secure credentials:
1. Please create `.env` file for your credentials:  
Write your credentials in " ". Do not have any space.  
> DB_HOST=""  
> DB_USER=""  
> DB_PASSWORD=""  
> DB_NAME="pocketmoney_db"  

#### Packages to pip install to run all the files:  
Please pip install the follwoing packages:  
- mysql-connector-python  
- python-dotenv  
- flask  
- requests  

#### How the files are connecting:  
- `config.py`:   
Require to import:    
**os** to set path.  
**dotenv** to load `.env` for credentials.          
**mysql.connector** to connect to the database and open cursor.    

- `db_utils.py`:  
Require to import:   
from    
**config** to import `config.py` 
import  
**get_db_connection** to connect to the datanase and opening cursor. 

This file is used to interact mysql creating helper functions to use in `app.py`.    

- `app.py`:  
Require to import:  
from  
**flask**  
import  
**Flask** to run flask app  
**request** to request json format to get      
**jsonify** to converts the Python dictionary into JSON response from flask module.   

To use functions in `db_utils.py`  
from  
**db_utils**
import  
**get_all_users**  
**get_all_accounts**  
**get_all_transactions**  
**get_account**  
**get_transactions_by_params**  
**get_account_balance**  
**insert_user**  
**insert_account**  
**insert_transaction**  

In this file, API endpoints are created using Flask app.    
To run flask app, please type **flask run** or type **flask --app app run**.    

- `main.py`:  
Require to import:    
**requests** to call the API created from client side.  

To run `main.py`, please run flask app in `app.py` first then run the run() function.    

#### Pocket Money Manager AIP ####  
The responses will retun in JSON format.  

#### API examples ####  

- API call to retrieve all users: http://127.0.0.1:5000/users  

###### Fields in API response ######    
`user_id`: int    
`user_name`: string    


- API call to retrieve all the accounts in the database: http://127.0.0.1:5000/accounts  

###### Fields in API response ######    
`account_id`: int    
`account_name`: string    
`created_at`: Date    


- API call to retrieve all the transacions in the database: http://127.0.0.1:5000/transactions  

###### Fields in API response ######    
`account_id`: int    
`amount`: decimal    
`description`: text    
`transaction_date`: Date    
`transacion_id`: int    
`transaction_type`: int    


- API call to retrieve an account with an user_id: http://127.0.0.1:5000/accounts/<int:user_id>  

###### Fields in API response ######    
`account_id`: int    
`account_name`: string  
`created_at`: Date  


- API call to retrieve transacions in an account: http://127.0.0.1:5000/transactions/<int:account_id>  

###### Fields in API response ######  
`account_id`: int  
`amount`: decimal  
`description`: text  
`transaction_date`: Date  
`transacion_id`: int  
`transaction_type`: int  


- API call to retrieve balance for each account: http://127.0.0.1:5000/balance

###### Fields in API response ######  
`account_id`: int  
`balance`: decimal  


- To add a new user : http://127.0.0.1:5000/users  
```
  new_user = {"user_name" : "#input new user name here"}  
  response = requests.post("http://127.0.0.1:5000/users", json=new_user)  
```
If user added succesfully:   
New user added successfully. New user ID: <int: new user id>  

If user alreay existed:  
User already exists.  


- To add a new account: http://127.0.0.1:5000/accounts

If creating for a new user, use variable: *max_user_id*, if existing user, input user_id  
```
  user_id = #input user_id here   
  new_account = {  
      "account_name": "#input new account name here",  
      "user_id": user_id,  
      "created_at": "#input creation date here" }  
  response = requests.post("http://127.0.0.1:5000/accounts", json=new_account)  
```
If account added succesfully:  
New account added successfully.  


- To add a new transaction: http://127.0.0.1:5000/transactions
```
  new_transaction = {  
      "account_id" : #input account_id here,  
      "amount": #input amount with decimal here*,  
      "transaction_type" : "#input transaction_type here",  
      "description" : "#input description here*",  
      "transaction_date" : "#input transaction date here" }  
  response = requests.post("http://127.0.0.1:5000/transactions", json=new_transaction)  
```
transaction_type to input: explanation for what is for:  
- allowance: for pocket moeny  
- spend: for all expense spent. Amount should be input with ***negative number***  
- reward: for any help  outside routine  
- gift: for any money given other than pocketmoney  
- fine: for any deduction, the parents decided. Amount should be input with ***negative number***  
- refund: for moeny the parents borrowed temporary.  

If account added succesfully:   
New transaction added succesfully.  







