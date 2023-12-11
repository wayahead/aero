class User < BaseModel
  # Include this module to add methods for
  # soft deleting and restoring
  include Avram::SoftDelete::Model

  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  struct Preferences
    include JSON::Serializable

    property? receive_email : Bool = true
  end

  table do
    column email : String
    column encrypted_password : String
    column name : String
    column status : String
    column roles : Array(String)
    column description : String?
    column preferences : User::Preferences?, serialize: true
    column soft_deleted_at : Time?

    belongs_to customer : Customer?
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
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

  def superadmin?
    "superuser".in? roles
  end

  def admin?
    ("administrator".in? roles) || ("superuser".in? roles)
  end

  def maintainer?
    "maintainer".in? roles
  end

  def operator?
    "operator".in? roles
  end
end
