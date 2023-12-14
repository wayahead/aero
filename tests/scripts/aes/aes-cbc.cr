require "random/secure"
require "openssl"
require "base64"

def aes_encrypt(data : String, *, key : String, secret : String) : String?
  begin
    base64_key = Base64.encode(key)

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

    base64_key + "." + Base64.encode(iv + enc)
  rescue
    nil
  end
end

def aes_decrypt(data : String, *, key : String, secret : String) : String?
  begin
    base64s = data.split(".")
    if base64s.size != 2
      return nil
    end

    base64_key = base64s[0]
    base64_data = base64s[1]

    if Base64.decode_string(base64_key) != key
      return nil
    end

    bytes = Base64.decode(base64_data)

    aes = OpenSSL::Cipher.new("aes-256-cbc")
    digest = OpenSSL::Digest.new("SHA256")

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
  rescue
    nil
  end
end

key = "加密解密测试"
secret = "abcdefghijklmnopqrstuvwxyz123456"
msg = "唐诗宋词：飞流直下三千尺，疑是银河落九天。"
enc = aes_encrypt(msg, key: key, secret: secret)
puts enc
unless enc.nil?
  dec = aes_decrypt(enc, key: key, secret: secret)
  puts dec
end
