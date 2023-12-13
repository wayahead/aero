class CreateAccessRequestAccess
  include JSON::Serializable
  property app : String
  property status : String?
  property description : String?
  property preferences : Access::Preferences?
end

class CreateAccessRequest
  include JSON::Serializable
  property access : CreateAccessRequestAccess
end

class Api::Accesses::Create < ApiAction
  post "/accesses" do
    begin
      req = CreateAccessRequest.from_json(params.body)

      # app is required in request, so app never be nil
      app = req.access.app
      if app.bytesize > 256 || app.bytesize < 2
        return json({
          message: "Unexpected request params",
          details: "The required param is wrong"
        }, HTTP::Status::BAD_REQUEST)
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
        status = status.downcase
        unless status.in? ["created", "activated", "suspended"]
          return json({
            message: "Unexpected request params",
            details: "The status is wrong"
          }, HTTP::Status::BAD_REQUEST)
        end
      end

      access = AccessQuery.new
        .app(app)
        .user_id(current_user.id)
        .first?
      if access.nil?
        created_access = CreateAccess.create!(params, user_id: current_user.id)
        json AccessSerializer.new(created_access)
      else
        return json({
          message: "Access already exists",
          details: "The access of app is exists"
        }, HTTP::Status::BAD_REQUEST)
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
