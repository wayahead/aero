Jwt.configure do |settings|
  if LuckyEnv.production?
    settings.secret_key = ENV.fetch("JWT_KEY") || "1ifRRGD4G45yGBiI8uypdU/eGJW0oqDoXWX0jgvJ8JU="
    settings.secret_expire = ENV.fetch("JWT_EXPIRE").to_i64 || 86400_i64
  else
    settings.secret_key = "1ifRRGD4G45yGBiI8uypdU/eGJW0oqDoXWX0jgvJ8JU="
    settings.secret_expire = 3600_i64
  end
end
