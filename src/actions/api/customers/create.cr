class CreateCustomerRequestCustomer
  include JSON::Serializable
  property name : String
  property status : String?
  property description : String?
end

class CreateCustomerRequest
  include JSON::Serializable
  property customer : CreateCustomerRequestCustomer
end

class Api::Customers::Create < ApiAction
  include Api::Auth::RequireSuperAdmin

  post "/customers" do
    begin
      req = CreateCustomerRequest.from_json(params.body)

      description = req.customer.description
      unless description.nil?
        if description.bytesize > 256
          return json({
            message: "Unexpected request params",
            details: "The description is too long"
          }, HTTP::Status::BAD_REQUEST)
        end
      end

      status = req.customer.status
      unless status.nil?
        status = status.as(String).downcase
        unless status.in? ["created", "activated", "suspended"]
          return json({
            message: "Unexpected request params",
            details: "The status is wrong"
          }, HTTP::Status::BAD_REQUEST)
        end
      end

      customer = CreateCustomer.create!(params)
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
    else
      head HTTP::Status::CREATED
    end
  end
end
