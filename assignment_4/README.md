### Assignment 4 ###

#### Pocket Money Manager AIP ####

I created Pocket Money Manager AIP to manage my children't pocket money and analyse the transactions

##### To set up DB:
1. Please use 'pocketmoney_management_db.sql' to create the database and insert some data into tables.

##### To secure credentials:
1. Please create `.env` file for your credentials:
Write your credentials in " ". Do not have any space.
> DB_HOST=""
> DB_USER=""
> DB_PASSWORD=""
> DB_NAME="pocketmoney_management_db"

##### Packages to pip install to run all the files:
Please pip install the follwoing packages:
- mysql-connector-python
- python-dotenv
- flask
- requests

##### How the files are connecting:
- `config.py`: the file importing credentials from `.env` using 3 modules, mysql.connector, os, dotenv
- `db_utils.py`: 




