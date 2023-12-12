class UserSerializer < BaseSerializer
  def initialize(@user : User)
  end

  def self.collection_key
    "users"
  end

  def render
    customer = if @user.customer_id.nil?
      nil
    else
      @user.customer_id.as(UUID).hexstring
    end

    {
      id: @user.id.hexstring,
      name: @user.name,
      email: @user.email,
      status: @user.status,
      roles: @user.roles,
      customer: customer,
      description: @user.description,
      preferences: @user.preferences,
      created_at: @user.created_at,
      updated_at: @user.updated_at,
      deleted_at: @user.soft_deleted_at
    }
  end
end
