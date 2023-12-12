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

print("[==]: change_password_admin_topease via superadmin")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False

data = json.dumps({
  "user": {
    "email": "wayahead@outlook.com",
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

#url = 'http://127.0.0.1:3000/api/v1/users/name/passwd/admin_topease'
url = 'http://127.0.0.1:3000/api/v1/users/passwd/a066902a-2b9b-4925-af8a-46a4322332e0'
error_flag = False

data = json.dumps({
  "user": {
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
  }
})

try:
  response = requests.put(url, data=data, headers=headers, timeout=5)
  # print("-inf:", response.headers)
  json_data = response.json()
  print("-inf:", response.status_code, json_data)
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
    print('*err: change_password_admin_topease via superadmin was failed')
    exit(1)
  else:
    print('-inf: change_password_admin_topease via superadmin was successful')

# Testcase 2

print("[==]: change_password_admin_bewise with superadmin")

#url = 'http://127.0.0.1:3000/api/v1/users/name/passwd/admin_bewise'
url = 'http://127.0.0.1:3000/api/v1/users/passwd/45372941-f53c-4327-a21b-f2d2a95539cd'
error_flag = False

data = json.dumps({
  "user": {
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
  }
})

try:
  response = requests.put(url, data=data, headers=headers, timeout=5)
  # print("-inf:", response.headers)
  json_data = response.json()
  print("-inf:", response.status_code, json_data)
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
    print('*err: change_password_admin_bewise via superadmin was failed')
    exit(1)
  else:
    print('-inf: change_password_admin_bewise via superadmin was successful')

# Testcase 3

print("[==]: change_password_superadmin_topease")

#url = 'http://127.0.0.1:3000/api/v1/users/name/passwd/superadmin_topease'
url = 'http://127.0.0.1:3000/api/v1/users/passwd/6a7ff57e-7f33-4f76-bba3-fbec985625f5'
error_flag = False

data = json.dumps({
  "user": {
    "password": "@NqGaKv*237+",
    "password_confirmation": "@NqGaKv*237+",
  }
})

try:
  response = requests.put(url, data=data, headers=headers, timeout=5)
  # print("-inf:", response.headers)
  json_data = response.json()
  print("-inf:", response.status_code, json_data)
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
    print('*err: change_password_superadmin_topease was failed')
    exit(1)
  else:
    print('-inf: change_password_superadmin_topease was successful')

print("[==]: change_password_superadmin_bewise")

#url = 'http://127.0.0.1:3000/api/v1/users/name/passwd/superadmin_bewise'
url = 'http://127.0.0.1:3000/api/v1/users/passwd/cbea955f-7f2d-494c-a1ab-41e133aff91e'
error_flag = False

data = json.dumps({
  "user": {
    "password": "@NqGaKv*237+",
    "password_confirmation": "@NqGaKv*237+",
  }
})

try:
  response = requests.put(url, data=data, headers=headers, timeout=5)
  # print("-inf:", response.headers)
  json_data = response.json()
  print("-inf:", response.status_code, json_data)
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
    print('*err: change_password_superadmin_bewise was failed')
    exit(1)
  else:
    print('-inf: change_password_superadmin_bewise was successful')
    exit(0)

# use $? in shell to check success or not
