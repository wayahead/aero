class Api::Access::Reset < ApiAction
  put "/accesses/reset/:access_id" do
    begin
      aid = UUID.parse?(access_id)
      if aid.nil?
        return json({
          message: "Invalid access id",
          details: "The access id is not valid"
        }, HTTP::Status::BAD_REQUEST)
      end

      access = AccessQuery.new
        .id(aid)
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
