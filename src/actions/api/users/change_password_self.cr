class ChangePasswordSelfRequest
  include JSON::Serializable
  property password : String
  property password_confirmation : String
end

class Api::Users::PasswordSelf < ApiAction
  include Api::Auth::RequireAdmin

  put "/me/passwd" do
    begin
      req = ChangePasswordSelfRequest.from_json(params.body)
      updated_user = ChangePassword.update!(
        current_user,
        password: req.password,
        password_confirmation: req.password_confirmation
      )
      json UserSerializer.new(updated_user)
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
