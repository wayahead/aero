class Api::Customers::Suspend < ApiAction
  include Api::Auth::RequireSuperAdmin

  put "/customers/suspend/:customer_id" do
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
      suspended_customer = SuspendCustomer.update!(customer)
      json CustomerSerializer.new(suspended_customer)
    end
  end
end
