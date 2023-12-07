class UserSerializer < BaseSerializer
  def initialize(@user : User)
  end

  def self.collection_key
    "users"
  end

  def render
    {
      id: @user.id,
      name: @user.name,
      email: @user.email,
      status: @user.status,
      roles: @user.roles,
      description: @user.description,
      customer: @user.customer_id,
      created_at: @user.created_at,
      updated_at: @user.updated_at
    }
  end
end
