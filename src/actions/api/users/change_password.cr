class ChangePasswordRequest
  include JSON::Serializable
  property password : String
  property password_confirmation : String
end

class Api::Users::Password < ApiAction
  include Api::Auth::RequireAdmin

  put "/users/passwd/:user_id" do
    begin
      req = ChangePasswordRequest.from_json(params.body)

      user = UserQuery.new
        .id(user_id)
        .with_soft_deleted
        .first?
      if user.nil?
        json({
          message: "Not found",
          details: "The user is not found"
        }, HTTP::Status::NOT_FOUND)
      else
        unless current_user.superadmin?
          unless user.customer_id == current_user.customer_id
            return json({
              message: "Permission denied",
              details: "The administrator is not responsible for user"
            }, HTTP::Status::FORBIDDEN)
          end
        end

        updated_user = ChangePassword.update!(
          user,
          password: req.password,
          password_confirmation: req.password_confirmation
        )
        json UserSerializer.new(updated_user)
      end
    rescue JSON::SerializableError
      json({
        message: "Unexpected request params",
        details: "Failed to decode request params"
      }, HTTP::Status::BAD_REQUEST)
    rescue TypeCastError
      json({
        message: "Unexpected request params",
        details: "Failed to cast request params"
      }, HTTP::Status::BAD_REQUEST)
    end
  end
end
