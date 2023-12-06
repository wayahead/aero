class Jwt
  Habitat.create do
    setting secret_key : String
    setting secret_expire : Int64
  end
end
