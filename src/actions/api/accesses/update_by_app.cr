class UpdateAccessByAppRequestAccess
  include JSON::Serializable
  property app : String?
  property status : String?
  property description : String?
  property preferences : Access::Preferences?
end

class UpdateAccessByAppRequest
  include JSON::Serializable
  property access : UpdateAccessByAppRequestAccess
end

class Api::Access::UpdateByApp < ApiAction
  put "/accesses/app/:access_app" do
    begin
      req = UpdateAccessByAppRequest.from_json(params.body)

      app = req.access.app
      unless app.nil?
        if app.bytesize > 256 || app.bytesize < 2
          return json({
            message: "Unexpected request params",
            details: "The app is wrong"
          }, HTTP::Status::BAD_REQUEST)
        end
      end

      description = req.access.description
      unless description.nil?
        if description.bytesize > 256
          return json({
            message: "Unexpected request params",
            details: "The description is too long"
          }, HTTP::Status::BAD_REQUEST)
        end
      end

      status = req.access.status
      unless status.nil?
        unless status.downcase.in? ["created", "activated", "suspended"]
          return json({
            message: "Unexpected request params",
            details: "The status is wrong"
          }, HTTP::Status::BAD_REQUEST)
        end
      end

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
        updated_access = UpdateAccess.update!(access, params)
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
