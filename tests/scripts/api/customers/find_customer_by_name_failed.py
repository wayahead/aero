#!/usr/bin/python3

import json
import random
import requests

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

print("[==]: find_customer_by_name_failed via admin")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False

data = json.dumps({
  "user": {
    "email": "admin@bewise.dev",
    "password": "WqA1yT2z",
  }
})

try:
  response = requests.post(url, data=data, headers=headers, timeout=5)
  json_data = response.json()
  # print("-inf:", response.status_code, json_data)
  if response.status_code != requests.codes.ok:
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
    print('*err: sign_in admin was failed')
    exit(1)
  else:
    print('-inf: sign_in admin was successful')

headers = {
  'User-Agent': random_user_agent,
  'Content-type': 'application/json',
  'Origin': 'windmill.com',
  'Authorization': "Bearer "+json_data["token"]
}

url = 'http://127.0.0.1:3000/api/v1/customers/name/Topease'
error_flag = False
try:
  response = requests.get(url, headers=headers, timeout=5)
  # print("-inf:", response.headers)
  json_data = response.json()
  print("-inf:", response.status_code, json_data)
  if response.status_code != requests.codes.forbidden:
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
    print('*err: find_customer_by_name was failed')
    exit(1)
  else:
    print('-inf: find_customer_by_name was successful')
    exit(0)

# use $? in shell to check success or not
