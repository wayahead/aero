import time
import base64
import hashlib
from Cryptodome.Random import get_random_bytes
from Cryptodome.Cipher import AES

BS = AES.block_size
pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS).encode()
unpad = lambda s: s[:-ord(s[len(s)-1:])]

def aes_encrypt(secret, data):
  data = data.encode("utf-8")
  raw = pad(data)
  key = hashlib.sha256(secret.encode("utf-8")).digest()
  iv = get_random_bytes(AES.block_size)
  cipher = AES.new(key, AES.MODE_CBC, iv)
  enc = cipher.encrypt(raw)
  # print(iv+enc)
  return base64.b64encode(iv+enc).decode("utf-8")

def aes_decrypt(secret, data):
  enc = base64.b64decode(data)
  key = hashlib.sha256(secret.encode("utf-8")).digest()
  iv = enc[:BS]
  cipher = AES.new(key, AES.MODE_CBC, iv)
  dec = cipher.decrypt(enc[BS:])
  return unpad(dec).decode('utf-8')

def generate(app, key, secret):
  key_base64 = base64.b64encode(key.encode('utf8')).decode("utf-8")
  now = time.time_ns() // 1_000_000
  access_token = key_base64+"."+aes_encrypt(secret, app+str(now))
  return access_token
