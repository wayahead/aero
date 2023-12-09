class Api::Users::Show < ApiAction
  include Api::Auth::RequireAdmin

  get "/users/:user_id" do
    uid = UUID.parse?(user_id)
    if uid.nil?
      return json({
        message: "Invalid user id",
        details: "The user id is not valid"
      }, HTTP::Status::BAD_REQUEST)
    end

    if current_user.superadmin?
      user = UserQuery.new.id(uid).first?
      if user.nil?
        json({
          message: "Not found",
          details: "The user was not found"
        }, HTTP::Status::NOT_FOUND)
      else
        json UserSerializer.new(user.as(User))
      end
    else
      if current_user.customer_id.nil?
        user = UserQuery.new
          .id(uid)
          .customer_id.is_nil
          .roles.not.includes("superuser")
          .first?
        if user.nil?
          json({
            message: "Not found",
            details: "The user was not found"
          }, HTTP::Status::NOT_FOUND)
        else
          json UserSerializer.new(user.as(User))
        end
      else
        user = UserQuery.new
          .id(uid)
          .customer_id(current_user.customer_id.not_nil!)
          .roles.not.includes("superuser")
          .first?
        if user.nil?
          json({
            message: "Not found",
            details: "The user was not found"
          }, HTTP::Status::NOT_FOUND)
        else
          json UserSerializer.new(user.as(User))
        end
      end
    end
  end

  get "/users/name/:user_name" do
    if current_user.superadmin?
      user = UserQuery.new.name(user_name).first?
      if user.nil?
        json({
          message: "Not found",
          details: "The user was not found"
        }, HTTP::Status::NOT_FOUND)
      else
        json UserSerializer.new(user.as(User))
      end
    else
      if current_user.customer_id.nil?
        user = UserQuery.new
          .name(user_name)
          .customer_id.is_nil
          .roles.not.includes("superuser")
          .first?
        if user.nil?
          json({
            message: "Not found",
            details: "The user was not found"
          }, HTTP::Status::NOT_FOUND)
        else
          json UserSerializer.new(user.as(User))
        end
      else
        user = UserQuery.new
          .name(user_name)
          .customer_id(current_user.customer_id.not_nil!)
          .roles.not.includes("superuser")
          .first?
        if user.nil?
          json({
            message: "Not found",
            details: "The user was not found"
          }, HTTP::Status::NOT_FOUND)
        else
          json UserSerializer.new(user.as(User))
        end
      end
    end
  end
end
