class AccessSerializer < BaseSerializer
  def initialize(@access : Access)
  end

  def self.collection_key
    "accesses"
  end

  def render
    {
      id: @access.id.hexstring,
      app: @access.app,
      key: @access.key,
      secret: @access.secret,
      status: @access.status,
      description: @access.description,
      preferences: @access.preferences,
      user: @access.user_id.hexstring,
      created_at: @access.created_at,
      updated_at: @access.updated_at,
    }
  end
end
