class Api::Access::ResetByApp < ApiAction
  put "/accesses/reset/app/:access_app" do
    begin
      access = AccessQuery.new
        .app(access_app)
        .user_id(current_user.id)
        .first?
      if access.nil?
        json({
          message: "Not found",
          details: "The access was not found"
        }, HTTP::Status::NOT_FOUND)
      else
        updated_access = ResetAccess.update!(access)
        json AccessSerializer.new(updated_access)
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
