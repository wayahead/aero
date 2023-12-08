class SignInRequestUser
  include JSON::Serializable
  property email : String
  property password : String
end

class SignInRequest
  include JSON::Serializable
  property user : SignInRequestUser
end

class Api::SignIns::Create < ApiAction
  include Api::Auth::SkipRequireAuthToken

  post "/sign_ins" do
    begin
      req = SignInRequest.from_json(params.body)
    rescue JSON::SerializableError
      json({
        message: "Unexpected request params",
      }, HTTP::Status::BAD_REQUEST)
    else
      SignInUser.run(params) do |operation, user|
        if user
          if user.active?
            json({token: UserToken.generate(user)})
          else
            json({
              message: "User not activated",
            }, HTTP::Status::FORBIDDEN)
          end
        else
          raise Avram::InvalidOperationError.new(operation)
        end
      end
    end
  end
end
