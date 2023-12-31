# Generates and decodes JSON Web Tokens for Authenticating users.
class UserToken
  Habitat.create { setting stubbed_token : String? }
  ALGORITHM = JWT::Algorithm::HS256

  def self.generate(user : User) : String
    payload = {
      # "user_id" => user.id.to_s,
      "user_id" => user.id.hexstring,
      "exp" => Time.utc.to_unix + Jwt.settings.secret_expire
    }

    settings.stubbed_token || create_token(payload)
  end

  def self.create_token(payload)
    JWT.encode(payload, Jwt.settings.secret_key, ALGORITHM)
  end

  # def self.decode_user_id(token : String) : Int64?
  #   payload, _header = JWT.decode(token, Jwt.settings.secret_key, ALGORITHM)
  #   payload["user_id"].to_s.to_i64
  # rescue e : JWT::Error
  #   Lucky::Log.dexter.error { {jwt_decode_error: e.message} }
  #   nil
  # end
  def self.decode_user_id(token : String) : String?
    payload, _header = JWT.decode(token, Jwt.settings.secret_key, ALGORITHM)
    payload["user_id"].to_s
  rescue e : JWT::Error
    Lucky::Log.dexter.error { {jwt_decode_error: e.message} }
    nil
  end

  # Used in tests to return a fake token to test against.
  def self.stub_token(token : String, &)
    temp_config(stubbed_token: token) do
      yield
    end
  end
end
