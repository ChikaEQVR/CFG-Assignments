# Have correct but minimal imports per file (do not import things you do not use in the file)
import requests

# get all users from the endpoint for users
response = requests.get("http://127.0.0.1:5000/users")
users = response.json
print(users)

# Implement client-side for each of the 3 API endpoints you have created.


# In main.py have a run() function/call the functions to simulate the
# planned interaction with the API, this could include welcome
# statements, displaying etc., (hairdressers booking example from
# lesson)

# add readme file
