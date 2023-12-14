require "random/secure"
require "openssl"
require "base64"

class AccessToken
  def self.generate(user : User, app : String) : String?
    access = AccessQuery.new
      .user_id(user.id)
      .app(app)
      .status("activated")
      .first?
    if access.nil?
      return nil
    end

    token_encode(access)
  end

  def self.decode_user_id(token : String) : UUID?
    token_decode(token)
  end

  private def self.encrypt(secret, data) : String
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

  private def self.token_encode(access : Access) : String?
    key = Base64.encode(access.key)
    key+"."+encrypt(access.secret, access.app+Time.utc.to_unix_ms.to_s)
  rescue
    nil
  end

  private def self.decrypt(secret, data) : String
    bytes = Base64.decode(data)

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
  end

  private def self.token_decode(token : String) : UUID?
    base64s = token.split(".")
    if base64s.size != 2
      return nil
    end

    key = Base64.decode_string(base64s[0])
    access = AccessQuery.new
      .key(key)
      .status("activated")
      .first?
    unless access.nil?
      dec = decrypt(access.secret, base64s[1])
      if dec.starts_with?(access.app)
        timestamp = dec.lchop(access.app).to_i64
        time = Time.unix_ms(timestamp)
        span = Time::Span.new(seconds: 300)
        if !(time > Time.utc+span || time < Time.utc-span)
          return access.user_id
        end
      end
    end
    nil
  rescue
    nil
  end
end
