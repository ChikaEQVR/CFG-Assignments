##
## Scenario : 
##
## I want to check the current weather and weather forecast to see when is good to put laundry outside to dry.
##

# Section 1. import all the modules required to run the code in laundry_openweather_api.py
import requests
import json
import datetime
import re
import secret # to get openweather api key so no need to share here
import pandas as pd # to read iso_country_code.csv into a dataframe to extract country names and codes

"""
APIs to use: 
1. OpenWeather API - https://openweathermap.org/
OpenWeather API to find out the current weather and wether forecast to determine when is good to put the laundry outside.
Please sign up to create an account to get API key. API key is available under "API keys" once created an account.
Please create secret.py and create a dictionary called 'secrets'. 
key name: openweather_api_key
value: OpenWeather API key 
This way, you dont't need to share your api key.

2. Geocoding API - https://openweathermap.org/api/geocoding-api?collection=other
This API is used to get location infomation for OpenWeather API. API key to use is OpenWeather API key.

"""
# Section 2. get OpenWeather api key from secret.py
openweather_api_key = secret.secrets["openweather_api_key"]

# Section 3. This part is all the information you need to call Geocoding API
"""
Reference data used:
1. iso_country_code.csv (original name: all.csv): https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes/tree/master/all
This csv file has all the countries codes information

2. UKGOV_postcode_format_doc.pdf: https://assets.publishing.service.gov.uk/media/5a81ebbded915d74e6234d42/Appendix_C_ILR_2017_to_2018_v1_Published_28April17.pdf
This file used to reference when making condition of postcode format using Regular Expression
"""

# Use boolean values and if..else statemts to branch logic of my program
# Read 'iso_country_code.csv' with a table format using pandas
country_codes_dataframe = pd.read_csv("iso_country_code.csv")
print(country_codes_dataframe)

# Eg) for UK, country code: 'GB' or country name: 
country_name_or_code = input("Enter country name or country code: eg) Japan or GB: ").lower()
country_name_df = country_codes_dataframe[ country_codes_dataframe["name"].str.lower() == country_name_or_code ] # .str.lower: dataframe brings data as object so change into string format then set string format as lowercase.
print(country_name_df) # to check for me if above code brings one row with all columns
if len(country_name_df) == 0: # if no rows comes back maching 'name' column,
    country_name_df = country_codes_dataframe[ country_codes_dataframe["alpha-2"].str.lower() == country_name_or_code ] # bring back rows matching with alpha-2
    print(country_name_df) # to check for me if above code brings one row with all columns
    if len(country_name_df) == 0: # if no rows comes back,
        raise Exception("you have typed in the invalid country name or code") # raise exception
    
country_code = country_name_df.iloc[0,1] # bring data from row number 0 and column number 1 which is country code requires.
print(country_code) # to check for me what country code comes back

# Raise Exception manually
class InvalidEntry(Exception):
    pass

try:
    postcode = input("Enter your postcode: ").upper()
    if not re.match(r"^[A-Z]{1,2}[0-9][0-9A-Z]? [0-9][ABD-HJLNP-UW-Z]{2}$", postcode):
        raise InvalidEntry("Invalid postcode")
    print(postcode)

except InvalidEntry as e:
    print(f"Error: {e}. Please type again.")

# Section 4. get location informatin from Geocoding API using the variables from Section 2 & 3
location_info_with_postcode_url = f"http://api.openweathermap.org/geo/1.0/zip?zip={postcode},{country_code}&appid={openweather_api_key}"
response = requests.get(location_info_with_postcode_url)
location_info_with_postcode = response.json()

print(location_info_with_postcode) # to check for me

# Set variables to use in OpenWeather API
loc_name = location_info_with_postcode["name"]
lat = location_info_with_postcode["lat"]
lon = location_info_with_postcode["lon"]

# Section 5. get some current weather information as json from OpenWeather API using the variables from Section 2 & 4
# Query the parameter to filter the API requests with metric unit
params = {
    "units" : "metric"
    }

weather_data_url = f"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={openweather_api_key}"
response = requests.get(weather_data_url, params=params) # get the informatin with the specific unit of measurements
weather_data = response.json()

print(weather_data) # to check for me

# Result #1: current weather information
current_weather = f"Current weather in {loc_name} is {weather_data["weather"][0]["main"]}"
current_temp = f"Temperature is {int(weather_data["main"]["temp"])} C and you feel like {int(weather_data["main"]["feels_like"])} C."
result1_current_weather = current_weather + "\n" + current_temp
print(result1_current_weather)

# Section 6. create functions with returns to make code reusable
# Function 1 with return
"""
This function is to convert speed from meter per second to miles per hour

"""
def speed_convert_calculation_to_mph(meter_per_second):
    return int(meter_per_second * 3600 / 1609.34)

# To check if the function is working
wind_speed_mph = speed_convert_calculation_to_mph(weather_data["wind"]["speed"])
print(f"Wind speed is {wind_speed_mph}mph.")

# Function 2 with return
"""
This function is to convert utc unix time to readable datetime: %Y/%b/%d %H:%M
"""
def display_datetime(utc_unix_time):
    x = datetime.datetime.fromtimestamp(utc_unix_time)
    return x.strftime("%Y/%b/%d %H:%M")

# Function 3 with return
"""
This function is to convert utc unix time to usable datetime object
"""
def to_datetime(utc_unix_time):
    return datetime.datetime.fromtimestamp(utc_unix_time)

# To check if the function is working
sunrise_time = weather_data["sys"]["sunrise"]
print(f"Sunrise is {display_datetime(sunrise_time)}")
print(f"Sunset is {display_datetime(weather_data["sys"]["sunset"])}")

# Section 7. get 3 hourly forecast from OpenWeather API using the variables from Section 2 & 4
forecast_data_url = f"https://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={openweather_api_key}"
response = requests.get(forecast_data_url, params=params)
forecast_data = response.json()

print(forecast_data) # to check for me

# Use a for loop or while loop to reduce repetition
# Use a data structure like list, dictionary, set or tuple to store values
"""
   Good condition for drying laundry outside is:
   Weather: dry
   Humidity: under 70%
   Wind: 8-12mph (best more than 15mph)
   tempreture: above zero (preferable above 21 °C)
   time to dry: between 10am and 4pm
   """
# Calculate yes / maybe / no and create a tuple list then get the overall reulst of when to put the laundry outside
my_list = forecast_data['list']
my_decision_list = []
my_all_data_dict = {}
for my_data in my_list:
    my_dt = my_data["dt"]  # display_datetime(my_data["dt"])  # to get time from 'list' key
    my_main = my_data["main"] # another dictionary in 'list' key so to get value 'main' to resuse to get value inside main dictionary instead of writing many key names each time.
    temp = float(my_main["temp"])  # tempreture from 'main' dictionary
    humidity = int(my_main["humidity"])  # humidity from 'main' dictionary
    speed = speed_convert_calculation_to_mph(my_data["wind"]["speed"])    # speed from 'wind' dictionary in 'list' dictionary
    my_all_data_dict[to_datetime(my_dt)] = (temp, humidity,speed)
    if temp >= 21 and humidity < 70 and speed >= 15:
        my_decision_list.append( (my_dt, "best") )
    elif 21 > temp >= 15 and humidity < 70 and 15 > speed >=8:
        my_decision_list.append( (my_dt, "ok") )
    elif 15 >= temp > 10 and humidity < 70 and 15 > speed >=8:
        my_decision_list.append( (my_dt, "maybe") )
    else:
        my_decision_list.append( (my_dt, "no") )

print(my_decision_list)   # to check for me

# Filter only 'yes', 'ok' and 'maybe'
my_good_for_outside_list = [ my_decision for my_decision in my_decision_list if my_decision[1] in ["yes", "ok", "maybe"]]
good_times_for_laundry_str = [display_datetime(time) for (time, decision) in my_good_for_outside_list] # changing time display to readable string
result2_good_time_for_laundry = f"List of good times to put laundry outside is {good_times_for_laundry_str}"
print(result2_good_time_for_laundry) # to check for me

# Filter only morning time from the 'my_good_for_outside_list'
good_times_for_laundry = [to_datetime(time) for (time, decision) in my_good_for_outside_list]
good_time_for_laundry_only_morning = [morning for morning in good_times_for_laundry if morning.hour < 12]
print(good_time_for_laundry_only_morning) # to check for me

# Pick up the earliest entry
best_time_for_laundry = good_time_for_laundry_only_morning[0]
print(my_all_data_dict) # to check for me
my_all_info_best_time_for_laundry = my_all_data_dict[best_time_for_laundry]
print(my_all_info_best_time_for_laundry) # to check for me

final_results = f"I recommend the best time to put laundry outside is {best_time_for_laundry}: Temperature: {my_all_info_best_time_for_laundry[0]} C / Humidity: {my_all_info_best_time_for_laundry[1]}% / Wind: {my_all_info_best_time_for_laundry[2]}mph. "
print(final_results) # to check for me

# Write your final results to a file (use syntax to write data into a file)  
with open ("final_results.txt", "w") as file:
    file.write(f"{result1_current_weather}\n{result2_good_time_for_laundry}\n{final_results}") 