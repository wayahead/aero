class Api::Users::Index < ApiAction
  get "/users" do
    if current_user.superadmin?
      # pages, users = paginate(UserQuery.new, per_page: 2)
      pages, users = paginate(UserQuery.new)
      json UserSerializer.for_collection(users, pages)
    elsif current_user.admin?
      if current_user.customer_id.nil?
        pages, users = paginate(UserQuery.new.customer_id.is_nil)
        json UserSerializer.for_collection(users, pages)
      else
        pages, users = paginate(UserQuery.new.customer_id(current_user.customer_id.not_nil!))
        json UserSerializer.for_collection(users, pages)
      end
    else
      json auth_denied_json, 403
    end
  end

  private def auth_denied_json
    ErrorSerializer.new(
      message: "Permission denied",
      details: "The administrator is required"
    )
  end
end
