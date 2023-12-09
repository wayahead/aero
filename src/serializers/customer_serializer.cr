class CustomerSerializer < BaseSerializer
  def initialize(@customer : Customer)
  end

  def self.collection_key
    "customers"
  end

  def render
    {
      id: @customer.id.hexstring,
      name: @customer.name,
      status: @customer.status,
      description: @customer.description,
      preferences: @customer.preferences,
      created_at: @customer.created_at,
      updated_at: @customer.updated_at
    }
  end
end
