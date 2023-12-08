#!/usr/bin/python3

import json
import random
import requests

url = 'http://127.0.0.1:3000/api/v1/sign_ups'
user_agents = [
  "Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0",
  "Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0",
  "Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101 Firefox/95.0"
  ]
random_user_agent = random.choice(user_agents)
headers = {
  'User-Agent': random_user_agent,
  'Content-type': 'application/json',
  'Origin': 'windmill.com'
}

# Testcase 1

print("testcase: sign_up with wrong customer")
error_flag = False
data = json.dumps({
  "user": {
    "name": "wayahead2009_w_wrong_customer",
    "email": "wayahead2009_w_wrong_customer@live.com",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "customer": "wrong customer"
  }
})

try:
  response = requests.post(url, data=data, headers=headers, timeout=5)
  json_data = response.json()
  print("inf:", response.status_code, json_data)
  if response.status_code != requests.codes.bad_request:
    error_flag = True
# Handle ConnectionError
except requests.exceptions.ConnectionError as ce:
    error_flag = True
    print('Connection error:', ce)
# Handle Timeout
except requests.exceptions.Timeout as te:
    error_flag = True
    print('Request timed out:', te)
# Handle HTTPError
except requests.exceptions.HTTPError as he:
    error_flag = True
    print('HTTP error occurred:', he)
# Handle ValueError
except ValueError as ve:
    error_flag = True
    print('JSON decoding error:', ve)
finally:
  if error_flag:
    print('err: sign_up with wrong customer was failed')
    exit(1)
  else:
    print('inf: sign_up with wrong customer was successful')

# Testcase 2

print("testcase: sign_up with customer")
error_falg = False
data = json.dumps({
  "user": {
    "name": "wayahead2009_w_customer",
    "email": "wayahead2009_w_customer@live.com",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "customer": "Bewise"
  }
})

try:
  response = requests.post(url, data=data, headers=headers, timeout=5)
  if response.status_code != requests.codes.created:
    error_flag = True
    json_data = response.json()
    print("inf:", response.status_code, json_data)
# Handle ConnectionError
except requests.exceptions.ConnectionError as ce:
    error_flag = True
    print('Connection error:', ce)
# Handle Timeout
except requests.exceptions.Timeout as te:
    error_flag = True
    print('Request timed out:', te)
# Handle HTTPError
except requests.exceptions.HTTPError as he:
    error_flag = True
    print('HTTP error occurred:', he)
# Handle ValueError
except ValueError as ve:
    error_flag = True
    print('JSON decoding error:', ve)
finally:
  if error_flag:
    print('err: sign_up with customer was failed')
    exit(1)
  else:
    print('inf: sign_up with customer was successful')

# Testcase 3

print("testcase: sign_up without customer")
error_flag = False
data = json.dumps({
  "user": {
    "name": "wayahead2009_wo_customer",
    "email": "wayahead2009_wo_customer@live.com",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z"
  }
})

try:
  response = requests.post(url, data=data, headers=headers, timeout=5)
  if response.status_code != requests.codes.created:
    error_flag = True
    json_data = response.json()
    print("inf", response.status_code, json_data)
# Handle ConnectionError
except requests.exceptions.ConnectionError as ce:
    error_flag = True
    print('Connection error:', ce)
# Handle Timeout
except requests.exceptions.Timeout as te:
    error_flag = True
    print('Request timed out:', te)
# Handle HTTPError
except requests.exceptions.HTTPError as he:
    error_flag = True
    print('HTTP error occurred:', he)
# Handle ValueError
except ValueError as ve:
    error_flag = True
    print('JSON decoding error:', ve)
finally:
  if error_flag:
    print('err: sign_up without customer was failed')
    exit(1)
  else:
    print('inf: sign_up without customer was successful')
    exit(0)

# use $? in shell to check success or not
