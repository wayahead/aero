class CreateUserRequestUser
  include JSON::Serializable
  property name : String
  property email : String
  property password : String
  property password_confirmation : String
  property status : String?
  property customer : String?
  property roles : Array(String)?
  property description : String?
  property preferences : Customer::Preferences?
end

class CreateUserRequest
  include JSON::Serializable
  property user : CreateUserRequestUser
end

class Api::Users::Create < ApiAction
  include Api::Auth::RequireAdmin

  post "/users" do
    begin
      req = CreateUserRequest.from_json(params.body)

      description = req.user.description
      unless description.nil?
        if description.bytesize > 256
          return json({
            message: "Unexpected request params",
            details: "The description is too long"
          }, HTTP::Status::BAD_REQUEST)
        end
      end

      status = req.user.status
      unless status.nil?
        status = status.downcase
        unless status.in? ["created", "activated", "suspended"]
          return json({
            message: "Unexpected request params",
            details: "The status is wrong"
          }, HTTP::Status::BAD_REQUEST)
        end
      end

      roles = req.user.roles
      unless roles.nil?
        roles = roles.map &.downcase
        if ("superuser".in? roles) || ("administrator".in? roles)
          unless current_user.superadmin?
            return json({
              message: "Permission denied",
              details: "The superadmin is required"
            }, HTTP::Status::FORBIDDEN)
          end
        end
      end

      customer_id : UUID? = current_user.customer_id
      customer_name = req.user.customer
      unless customer_name.nil?
        customer = CustomerQuery.new.name(customer_name).first?
        if customer.nil?
          return json({
            message: "Unexpected request params",
            details: "The customer is not found"
          }, HTTP::Status::BAD_REQUEST)
        elsif !customer.active?
          return json({
            message: "Unexpected request params",
            details: "The customer is not activated"
          }, HTTP::Status::BAD_REQUEST)
        else
          customer_id = customer.id
          unless current_user.superadmin?
            unless customer.id == current_user.customer_id
              return json({
                message: "Permission denied",
                details: "The administrator is not responsible for customer"
              }, HTTP::Status::FORBIDDEN)
            end
          end
        end
      end

      # The named parameter `customer_id` is transferred to operation so
      # you can use `permit_columns customer_id` to save to model, which
      # causes no necessary to transfer `current_user` to operation.
      user = CreateUser.create!(params, customer_id: customer_id)
      json UserSerializer.new(user)
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
