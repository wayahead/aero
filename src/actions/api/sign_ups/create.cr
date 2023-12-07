class SignUpRequestUser
  include JSON::Serializable
  property name : String
  property email : String
  property password : String
  property password_confirmation : String
  property customer : String?
end

class SignUpRequest
  include JSON::Serializable
  property user : SignUpRequestUser
end

class Api::SignUps::Create < ApiAction
  include Api::Auth::SkipRequireAuthToken

  post "/sign_ups" do
    begin
      req = SignUpRequest.from_json(params.body)
      user = SignUpUser.create!(params)
    rescue JSON::SerializableError
      json({
        message: "Unexpected request params",
      }, HTTP::Status::BAD_REQUEST)
    rescue TypeCastError
      json({
        message: "Unexpected request params",
      }, HTTP::Status::BAD_REQUEST)
    else
      # response with 200 OK with token
      # json({token: UserToken.generate(user)})
      # or just response with 201 Created
      head HTTP::Status::CREATED
    end
  end
end
