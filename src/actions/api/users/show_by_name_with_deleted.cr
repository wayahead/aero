class Api::Users::ShowByNameWithDeleted < ApiAction
  include Api::Auth::RequireAdmin

  get "/users_with_deleted/name/:user_name" do
    if current_user.superadmin?
      user = UserQuery.new
        .name(user_name)
        .with_soft_deleted
        .first?
      if user.nil?
        json({
          message: "Not found",
          details: "The user was not found"
        }, HTTP::Status::NOT_FOUND)
      else
        json UserSerializer.new(user)
      end
    else
      if current_user.customer_id.nil?
        user = UserQuery.new
          .name(user_name)
          .customer_id.is_nil
          .with_soft_deleted
          .roles.not.includes("superuser")
          .first?
        if user.nil?
          json({
            message: "Not found",
            details: "The user was not found"
          }, HTTP::Status::NOT_FOUND)
        else
          json UserSerializer.new(user)
        end
      else
        user = UserQuery.new
          .name(user_name)
          .customer_id(current_user.customer_id.not_nil!)
          .with_soft_deleted
          .roles.not.includes("superuser")
          .first?
        if user.nil?
          json({
            message: "Not found",
            details: "The user was not found"
          }, HTTP::Status::NOT_FOUND)
        else
          json UserSerializer.new(user)
        end
      end
    end
  end
end
