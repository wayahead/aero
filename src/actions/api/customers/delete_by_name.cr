class Api::Customers::DeleteByName < ApiAction
  include Api::Auth::RequireSuperAdmin

  delete "/customers/name/:customer_name" do
    customer = CustomerQuery.new
      .name(customer_name)
      .first?
    if customer.nil?
      json({
        message: "Not found",
        details: "The customer was not found"
      }, HTTP::Status::NOT_FOUND)
    else
      # DeleteCustomer.delete(customer) do |operation, deleted_customer|
      #   if operation.deleted?
      #     json CustomerSerializer.new(deleted_customer.as(Customer))
      #   else
      #     json({
      #       message: "Something went wrong",
      #       details: "The customer was not deleted"
      #     }, HTTP::Status::INTERNAL_SERVER_ERROR)
      #   end
      # end
      deleted_customer = DeleteCustomer.delete!(customer)
      json CustomerSerializer.new(deleted_customer.as(Customer))
    end
  end
end
