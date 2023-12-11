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
      created_at: @access.created_at,
      updated_at: @access.updated_at,
      deleted_at: @access.soft_deleted_at
    }
  end
end
