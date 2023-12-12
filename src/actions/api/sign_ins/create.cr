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

      SignInUser.run(params) do |operation, user|
        if user
          unless user.customer_id.nil?
            customer = CustomerQuery.new.id(user.customer_id.not_nil!).first?
            if customer.nil?
              return json({
                message: "Unauthorized",
                details: "The group is not available"
              }, HTTP::Status::UNAUTHORIZED)
            elsif !customer.active?
              return json({
                message: "Unauthorized",
                details: "The group is not activated"
              }, HTTP::Status::UNAUTHORIZED)
            end
          end

          if user.active?
            json({token: UserToken.generate(user)})
          else
            json({
              message: "Not activated",
              details: "The user is not activated"
            }, HTTP::Status::UNAUTHORIZED)
          end
        else
          raise Avram::InvalidOperationError.new(operation)
        end
      end
    rescue JSON::SerializableError
      json({
        message: "Unexpected request params",
        details: "Failed to decode request params"
      }, HTTP::Status::BAD_REQUEST)
    end
  end
end
