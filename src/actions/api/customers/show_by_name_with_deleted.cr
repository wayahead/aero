class Api::Customers::ShowByNameWithDeleted < ApiAction
  include Api::Auth::RequireSuperAdmin

  get "/customers_with_deleted/name/:customer_name" do
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
      json CustomerSerializer.new(customer)
    end
  end
end
