### Assignment 4 ###

I created Pocket Money Manager AIP to manage my children't pocket money and analyse the transactions

##### To set up DB:
1. Please use 'pocketmoney_db.sql' to create the database and insert some data into tables.

##### To secure credentials:
1. Please create `.env` file for your credentials:
Write your credentials in " ". Do not have any space.
> DB_HOST=""
> DB_USER=""
> DB_PASSWORD=""
> DB_NAME="pocketmoney_db"

##### Packages to pip install to run all the files:
Please pip install the follwoing packages:
- mysql-connector-python
- python-dotenv
- flask
- requests

##### How the files are connecting:
- `config.py`: 
It is importing credentials from `.env` using 2 modules: **os**, **dotenv**
It is also connecting to the database and opening cursor using **mysql.connector** module

- `db_utils.py`:
It is importing `config.py` to connect to the datanase and opening cursor
This file is used to interact mysql creating helper functions to use in `app.py`

- `app.py`:
It is importing **Flask** to run flask app, **request** to request json format to get, **jsonify** to converts the Python dictionary into JSON response from **flask** module
In this file, API endpoints are created using Flask app.
To run flask app, please type **flask run** or type **flask --app app run**

- `main.py`:
It is importing **requests** to call the API created from client side.

#### Pocket Money Manager AIP ####
###### How to make an API call ######

API call

http://127.0.0.1:5000/balance

###### Fields in API response ######
account_id: account id, int
balance: balance of each account, decimal 




