class Api::Customers::ActivateByName < ApiAction
  include Api::Auth::RequireSuperAdmin

  put "/customers/name/activate/:customer_name" do
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
      activated_customer = ActivateCustomer.update!(customer)
      json CustomerSerializer.new(activated_customer)
    end
  end
end
