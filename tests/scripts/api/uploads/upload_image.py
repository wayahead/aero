#!/usr/bin/python3

import http
import json
import random
import requests
import logging

"""
def patch_send():
    old_send = http.client.HTTPConnection.send
    def new_send(self, data):
        print(f'{"-"*9} BEGIN REQUEST {"-"*9}')
        #print(data.decode('utf-8').strip())
        print(data.decode('ascii').strip())
        print(f'{"-"*10} END REQUEST {"-"*10}')
        return old_send(self, data)
    http.client.HTTPConnection.send = new_send
patch_send()
"""

def httpclient_log(*args):
    print(args)
    # logging.getLogger('requests.packages.urllib3').log(logging.DEBUG, " ".join(args))
http.client.HTTPConnection.debuglevel = 1
logging.basicConfig()
logging.getLogger().setLevel(logging.DEBUG)
requests_log = logging.getLogger("requests.packages.urllib3")
requests_log.setLevel(0)
requests_log.propagate = True
http.client.print = httpclient_log

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

print("[==]: upload_image")

url = 'http://127.0.0.1:3000/api/v1/sign_ins'
error_flag = False
json_data = {}

data = json.dumps({
  "user": {
    "email": "wayahead@outlook.com",
    "password": "@NqGaKv*237+",
  }
})

try:
  response = requests.post(url, data=data, headers=headers, timeout=5)
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
    print('*err: sign_in was failed')
    exit(1)
  else:
    print('-inf: sign_in was successful')

headers = {
  'User-Agent': random_user_agent,
  #'Content-Type': 'multipart/form-data',
  'Origin': 'windmill.com',
  'Authorization': "Bearer "+json_data["token"]
}

# files = {'profile_image': open('{file_path}', 'rb')}
files = {'image': open('./dev.png', 'rb')}

url = 'http://127.0.0.1:3000/api/v1/uploads/image'
error_flag = False
try:
  response = requests.post(url, files=files, headers=headers, timeout=5)
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
  print(ve)
  print('JSON decoding error:', ve)
finally:
  if error_flag:
    print('*err: upload_image was failed')
    exit(1)
  else:
    print('-inf: upload_image was successful')
    exit(0)
