class UserSelfSerializer < BaseSerializer
  def initialize(@user : User)
  end

  def self.collection_key
    "users"
  end

  def render
    {
      id: @user.id.hexstring,
      name: @user.name,
      email: @user.email,
      status: @user.status,
      roles: @user.roles,
      description: @user.description
    }
  end
end
