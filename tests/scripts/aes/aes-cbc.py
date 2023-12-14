#!/usr/bin/python3

# https://gist.github.com/wowkin2/a2b234c87290f6959c815d3c21336278
# https://www.quickprogrammingtips.com/python/aes-256-encryption-and-decryption-in-python.html

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

key = 'abcdefghijklmnopqrstuvwxyz123456'
message = '唐诗宋词：飞流直下三千尺，疑是银河落九天。'

enc = aes_encrypt(key, message)
dec = aes_decrypt(key, enc)

print("original message: "+message)
print("encoded message : "+enc)
print("decoded message : "+dec)
print(message == dec)
