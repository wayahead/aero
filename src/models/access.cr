class Access < BaseModel
  struct Preferences
    include JSON::Serializable

    property? digest : String = "md5"
    property? cipher : String = "aes-256-cbc"
  end

  table do
    column app : String
    column key : String
    column secret : String
    column status : String
    column preferences : User::Preferences?, serialize: true

    belongs_to user : User
  end

  def active?
    status.downcase == "activated"
  end

  def deleted?
    status.downcase == "deleted"
  end

  def suspended?
    status.downcase == "suspended"
  end
end
