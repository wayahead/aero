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

# Testcase 1

print("[==]: create_admin via superadmin")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False

data = json.dumps({
  "user": {
    "email": "wayahead@bewise.dev",
    "password": "@NqGaKv*237+",
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
    print('*err: sign_in superadmin was failed')
    exit(1)
  else:
    print('-inf: sign_in superadmin was successful')

headers = {
  'User-Agent': random_user_agent,
  'Content-type': 'application/json',
  'Origin': 'windmill.com',
  'Authorization': "Bearer "+json_data["token"]
}

url = 'http://127.0.0.1:3000/api/v1/users'
error_flag = False

data = json.dumps({
  "user": {
    "name": "admin",
    "email": "admin@bewise.dev",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "status": "activated",
    "customer": "bewise",
    "roles": ["administrator"]
  }
})

try:
  response = requests.post(url, data=data, headers=headers, timeout=5)
  # print("-inf:", response.headers)
  if response.status_code != requests.codes.created:
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
    print('*err: create_admin via superadmin was failed')
    exit(1)
  else:
    print('-inf: create_admin via superadmin was successful')

# Testcase 2

print("[==]: create_user with superadmin without status, customer and roles")

url = 'http://127.0.0.1:3000/api/v1/users'
error_flag = False

data = json.dumps({
  "user": {
    "name": "admin_wo",
    "email": "admin_wo@bewise.dev",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "roles": ["administrator"]
  }
})

try:
  response = requests.post(url, data=data, headers=headers, timeout=5)
  # print("-inf:", response.headers)
  if response.status_code != requests.codes.created:
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
    print('*err: create_admin via superadmin without status, customer and roles was failed')
    exit(1)
  else:
    print('-inf: create_admin via superadmin without status, customer and roles was successful')

# Testcase 3

print("[==]: create_superadmin")

url = 'http://127.0.0.1:3000/api/v1/users'
error_flag = False

data = json.dumps({
  "user": {
    "name": "superadmin",
    "email": "superadmin@bewise.dev",
    "description": "super administrator",
    "password": "@NqGaKv*237+",
    "password_confirmation": "@NqGaKv*237+",
    "roles": ["superadmin"]
  }
})

try:
  response = requests.post(url, data=data, headers=headers, timeout=5)
  # print("-inf:", response.headers)
  if response.status_code != requests.codes.created:
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
    print('*err: create_superadmin was failed')
    exit(1)
  else:
    print('-inf: create_superadmin was successful')
    exit(0)

# use $? in shell to check success or not
