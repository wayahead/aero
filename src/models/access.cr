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
    column description : String?
    column preferences : Access::Preferences?, serialize: true

    belongs_to user : User
  end

  def active?
    (status.downcase == "activated") && (!soft_deleted_at.nil?)
  end

  def suspended?
    (status.downcase == "suspended") && (!soft_deleted_at.nil?)
  end

  def deleted?
    !soft_deleted_at.nil?
  end
end
