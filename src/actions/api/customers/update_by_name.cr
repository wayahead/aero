class UpdateCustomerByNameRequestCustomer
  include JSON::Serializable
  property name : String?
  property status : String?
  property description : String?
  property preferences : Customer::Preferences?
end

class UpdateCustomerByNameRequest
  include JSON::Serializable
  property customer : UpdateCustomerByNameRequestCustomer
end

class Api::Customers::UpdateByName < ApiAction
  include Api::Auth::RequireSuperAdmin

  put "/customers/name/:customer_name" do
    begin
      req = UpdateCustomerByNameRequest.from_json(params.body)

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
        unless status.downcase.in? ["created", "activated", "suspended"]
          return json({
            message: "Unexpected request params",
            details: "The status is wrong"
          }, HTTP::Status::BAD_REQUEST)
        end
      end

      customer = CustomerQuery.new
        .name(customer_name)
        .with_soft_deleted
        .first?
      if customer.nil?
        json({
          message: "Not found",
          details: "The customer was not found"
        }, HTTP::Status::NOT_FOUND)
      else
        updated_customer = UpdateCustomer.update!(customer, params)
        json CustomerSerializer.new(updated_customer)
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
