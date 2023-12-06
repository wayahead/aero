#!/usr/bin/python3

import json
import random
import requests

url = 'http://127.0.0.1:3000/api/v1/sign_ups'
data = json.dumps({
  "user": {
    "name": "wayahead2009",
    "email": "wayahead2009@live.com",
    "password": "WqA1yT2z",
    "password_confirmation": "WqA1yT2z"
  }
})

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

try:
  response = requests.post(url, data=data, headers=headers, timeout=5)
  json_data = response.json()
# Handle ConnectionError
except requests.exceptions.ConnectionError as ce:
    print('Connection error:', ce)
# Handle Timeout
except requests.exceptions.Timeout as te:
    print('Request timed out:', te)
# Handle HTTPError
except requests.exceptions.HTTPError as he:
    print('HTTP error occurred:', he)
# Handle ValueError
except ValueError as ve:
    print('JSON decoding error:', ve)
else:
  if response.status_code == requests.codes.ok:
    print('Sign_up was successful')
    print(json_data)
    exit(0)
  else:
    print('Sign_up failed with status code:', response.status_code)
    print(json_data)
    exit(1)

# use $? in shell to check success or not
