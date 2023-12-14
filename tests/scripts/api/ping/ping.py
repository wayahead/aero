#!/usr/bin/python3

import sys
import json
import random
import requests

sys.path.append("../../aes/")
import access_token

app = "testapp"
key = "f077d43890434c8185b21a196bc99968"
secret = "1df8b63226e0472389d6734e81004eb9"
token = access_token.generate(app, key, secret)
print("-inf: "+token)

user_agents = [
  "Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0",
  "Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0",
  "Mozilla/5.0 (X11; Linux x86_64; rv:95.0) Gecko/20100101 Firefox/95.0"
  ]
random_user_agent = random.choice(user_agents)
headers = {
  'User-Agent': random_user_agent,
  'Content-type': 'application/json',
  'Origin': 'windmill.com',
  'Authorization': 'Enabler '+token
}

print("[==]: ping test")

url = 'http://127.0.0.1:3000/api/v1/ping'
error_flag = False

try:
  response = requests.get(url, headers=headers, timeout=5)
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
    print('*err: ping_test was failed')
    exit(1)
  else:
    print('-inf: ping test was successful')
    exit(0)

# use $? in shell to check success or not
