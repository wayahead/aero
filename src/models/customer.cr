class Customer < BaseModel
  struct Preferences
    include JSON::Serializable

    property? auto_renewal : Bool = false
  end

  table do
    column name : String
    column status : String
    column description : String?
    column preferences : Customer::Preferences?, serialize: true
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
