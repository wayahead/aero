class Api::Customers::ShowByName < ApiAction
  include Api::Auth::RequireSuperAdmin

  get "/customer/name/:customer_name" do
    customer = CustomerQuery.new.name(customer_name).first?
    if customer.nil?
      json({
        message: "Not found",
        details: "The customer was not found"
      }, HTTP::Status::NOT_FOUND)
    else
      json CustomerSerializer.new(customer.as(Customer))
    end
  end
end
