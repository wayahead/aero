class Api::Customers::Show < ApiAction
  include Api::Auth::RequireSuperAdmin

  get "/customers/:customer_id" do
    cid = UUID.parse?(customer_id)
    if cid.nil?
      return json({
        message: "Invalid customer id",
        details: "The customer id is not valid"
      }, HTTP::Status::BAD_REQUEST)
    end

    customer = CustomerQuery.new.id(cid).first?
    if customer.nil?
      json({
        message: "Not found",
        details: "The customer was not found"
      }, HTTP::Status::NOT_FOUND)
    else
      json CustomerSerializer.new(customer.as(Customer))
    end
  end

  get "/customers/name/:customer_name" do
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
