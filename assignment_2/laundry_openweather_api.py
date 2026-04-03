# scenario 
# I want to check wheather forecast in the morning and see if it's good to put laundry outside to dry or not and best time to put outside.
# Also want to know wheather you need to take an umbrella to keep me dry or another layer to keep me warm

# explain how the instructor can set up api keys:
# explained in README.md file

# explain how i am using the api:
# expalined in README.md file

# get api key
OpenWeather_api_key = "b3adcd4f1beaa3665b4c04d6ee7024a8"

import requests
import json

# get some information as json from open weather api

# query the parameter to filter the API requests with metric unit
params = {
    "units" : "metric"
    }

# GET / current weather data - API endpoint: "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}"
weather_data_url = f"https://api.openweathermap.org/data/2.5/weather?lat=51.44762377771111&lon=-0.13611814642951464&appid={OpenWeather_api_key}"
response = requests.get(weather_data_url, params=params) # get the informatin with the specific unit of measurements
weather_data = response.json()

print(weather_data)

print(f"Today's weather is {weather_data["weather"][0]["main"]}.")
print(f"Today's temperature is {weather_data["main"]["temp"]}°C and you feel like {weather_data["main"]["feels_like"]}°C.")
print(f"Today's humidity is {weather_data["main"]["humidity"]}%.")

# use functions with returns to make code reusable
"""
This function is to convert speed from meter per second to miles per hour

"""
def speed_convert_calculation_to_mph(meter_per_second):
    return int(meter_per_second * 3600 / 1609.34)

wind_speed_mph = speed_convert_calculation_to_mph(weather_data["wind"]["speed"])
print(f"Today's wind speed is {wind_speed_mph}mph.")

# import extra module eg panda to save to csv










# use string slicing


# use a for loop or while loop tp reduce repetition


# use a data structure like list, dictionary, set or tuple to store values


# use boolean values and if..else stat,emts to branch logic of your program



# write your final results to a file (use syntax to write data into a file)   