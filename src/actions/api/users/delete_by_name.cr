class Api::Users::DeleteByName < ApiAction
  include Api::Auth::RequireAdmin

  delete "/users/name/:user_name" do
    if current_user.superadmin?
      user = UserQuery.new.name(user_name).first?
      if user.nil?
        json({
          message: "Not found",
          details: "The user was not found"
        }, HTTP::Status::NOT_FOUND)
      else
        puts "deleting"
        deleted_user = DeleteUser.delete!(user)
        json UserSerializer.new(deleted_user)
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
          puts "deleting"
          deleted_user = DeleteUser.delete!(user)
          json UserSerializer.new(deleted_user)
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
          puts "deleting"
          deleted_user = DeleteUser.delete!(user)
          json UserSerializer.new(deleted_user)
        end
      end
    end
  end
end
