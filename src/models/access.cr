class Access < BaseModel
  # Include this module to add methods for
  # soft deleting and restoring
  include Avram::SoftDelete::Model

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
    column preferences : User::Preferences?, serialize: true
    column soft_deleted_at : Time?

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
