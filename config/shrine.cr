Shrine.configure do |config|
  config.storages["cache"] = Shrine::Storage::FileSystem.new("public", prefix: "cache")
  config.storages["store"] = Shrine::Storage::FileSystem.new("public", prefix: "uploads")
end
