class Api::Customers::Activate < ApiAction
  include Api::Auth::RequireSuperAdmin

  put "/customers/activate/:customer_id" do
    customer = CustomerQuery.new
      .id(customer_id)
      .with_soft_deleted
      .first?
    if customer.nil?
      json({
        message: "Not found",
        details: "The customer was not found"
      }, HTTP::Status::NOT_FOUND)
    else
      activated_customer = ActivateCustomer.update!(customer)
      json CustomerSerializer.new(activated_customer)
    end
  end
end
