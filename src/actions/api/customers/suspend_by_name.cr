class Api::Customers::SuspendByName < ApiAction
  include Api::Auth::RequireSuperAdmin

  put "/customers/name/suspend/:customer_name" do
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
      suspended_customer = SuspendCustomer.update!(customer)
      json CustomerSerializer.new(suspended_customer)
    end
  end
end
