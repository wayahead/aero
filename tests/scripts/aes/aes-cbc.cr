require "random/secure"
require "openssl"

def aes_encrypt(secret, data)
  aes = OpenSSL::Cipher.new("aes-256-cbc")
  digest = OpenSSL::Digest.new("SHA256")
  iv = Random::Secure.random_bytes(16)

  digest.update(secret)
  key = digest.final

  aes.padding = true
  aes.encrypt
  aes.key = key
  aes.iv = iv
  enc = aes.update(data)
  enc = enc + aes.final

  Base64.encode(iv + enc)
end

def aes_decrypt(secret, data)
  aes = OpenSSL::Cipher.new("aes-256-cbc")
  digest = OpenSSL::Digest.new("SHA256")

  bytes = Base64.decode(data)

  digest.update(secret)
  key = digest.final

  aes.padding = true
  aes.decrypt
  aes.key = key
  aes.iv = bytes[...aes.block_size]

  io = IO::Memory.new
  io.write(aes.update(bytes[aes.block_size..]))
  io.write(aes.final)
  io.rewind

  io.gets_to_end
end

key = "abcdefghijklmnopqrstuvwxyz123456"
msg = "唐诗宋词：飞流直下三千尺，疑是银河落九天。"
enc = aes_encrypt(key, msg)
puts enc
dec = aes_decrypt(key, enc)
puts dec
