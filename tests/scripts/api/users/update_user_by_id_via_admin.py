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

print("[==]: update_user via admin_topease")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False

data = json.dumps({
  "user": {
    "email": "admin_topease@topease.com",
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

url = 'http://127.0.0.1:3000/api/v1/users/5978a878-0208-472a-95c5-0a962268e408'
error_flag = False

data = json.dumps({
  "user": {
    "name": "test1_topease",
    "email": "test1_topease@tests.dev",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "description": "test of topease",
    "status": "activated",
    "customer": "topease",
    "roles": ["operator"],
    "preferences": {"receive_email": False}
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
    print('*err: update_user_topease via admin_topease was failed')
    exit(1)
  else:
    print('-inf: update_user_topease via admin_topease was successful')

# Testcase 2

print("[==]: update_user_bewise with admin_bewise")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False

data = json.dumps({
  "user": {
    "email": "admin_bewise@bewise.dev",
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

url = 'http://127.0.0.1:3000/api/v1/users/5fea1ab8-59fa-4b18-9a27-53d64dc1fa90'
error_flag = False

data = json.dumps({
  "user": {
    "name": "test1_bewise",
    "email": "test1_bewise@tests.dev",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "description": "test of bewise",
    "customer": "bewise",
    "roles": ["operator"],
    "preferences": {"receive_email": False}
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
    print('*err: update_user_bewise via admin_bewise was failed')
    exit(1)
  else:
    print('-inf: update_user_bewise via admin_bewise was successful')

# Testcase 3

print("[==]: update_useri_failed via admin_topease")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False

data = json.dumps({
  "user": {
    "email": "admin_topease@topease.com",
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

url = 'http://127.0.0.1:3000/api/v1/users/5978a878-0208-472a-95c5-0a962268e408'
error_flag = False

data = json.dumps({
  "user": {
    "name": "test1_topease",
    "email": "test1_topease@tests.dev",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "description": "test of topease",
    "status": "activated",
    "customer": "bewise",
    "roles": ["operator"],
    "preferences": {"receive_email": False}
  }
})

try:
  response = requests.put(url, data=data, headers=headers, timeout=5)
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
    print('*err: update_user_topease_failed via admin_topease was failed')
    exit(1)
  else:
    print('-inf: update_user_topease_failed via admin_topease was successful')

# Testcase 4

print("[==]: update_user_bewise_failed with admin_bewise")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False

data = json.dumps({
  "user": {
    "email": "admin_bewise@bewise.dev",
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

url = 'http://127.0.0.1:3000/api/v1/users/5fea1ab8-59fa-4b18-9a27-53d64dc1fa90'
error_flag = False

data = json.dumps({
  "user": {
    "name": "test1_bewise",
    "email": "test1_bewise@tests.dev",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "description": "test of bewise",
    "customer": "topease",
    "roles": ["operator"],
    "preferences": {"receive_email": False}
  }
})

try:
  response = requests.put(url, data=data, headers=headers, timeout=5)
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
    print('*err: update_user_bewise_failed via admin_bewise was failed')
    exit(1)
  else:
    print('-inf: update_user_bewise_failed via admin_bewise was successful')

# Testcase 5

print("[==]: update_useri_failed via admin_topease")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False

data = json.dumps({
  "user": {
    "email": "admin_topease@topease.com",
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

url = 'http://127.0.0.1:3000/api/v1/users/5fea1ab8-59fa-4b18-9a27-53d64dc1fa90'
error_flag = False

data = json.dumps({
  "user": {
    "name": "testx_topease",
    "email": "testx_topease@tests.dev",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "description": "test of topease",
    "status": "activated",
    "customer": "topease",
    "roles": ["operator"],
    "preferences": {"receive_email": False}
  }
})

try:
  response = requests.put(url, data=data, headers=headers, timeout=5)
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
    print('*err: update_user_topease_failed via admin_topease was failed')
    exit(1)
  else:
    print('-inf: update_user_topease_failed via admin_topease was successful')

# Testcase 6

print("[==]: update_user_bewise_failed with admin_bewise")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False

data = json.dumps({
  "user": {
    "email": "admin_bewise@bewise.dev",
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

url = 'http://127.0.0.1:3000/api/v1/users/5978a878-0208-472a-95c5-0a962268e408'
error_flag = False

data = json.dumps({
  "user": {
    "name": "testx_bewise",
    "email": "testx_bewise@tests.dev",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z",
    "description": "test of bewise",
    "customer": "bewise",
    "roles": ["operator"],
    "preferences": {"receive_email": False}
  }
})

try:
  response = requests.put(url, data=data, headers=headers, timeout=5)
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
    print('*err: update_user_bewise_failed via admin_bewise was failed')
    exit(1)
  else:
    print('-inf: update_user_bewise_failed via admin_bewise was successful')
    exit(0)

# use $? in shell to check success or not
