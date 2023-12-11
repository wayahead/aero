class Api::Customers::ShowWithDeleted < ApiAction
  include Api::Auth::RequireSuperAdmin

  get "/customers_with_deleted/:customer_id" do
    cid = UUID.parse?(customer_id)
    if cid.nil?
      return json({
        message: "Invalid customer id",
        details: "The customer id is not valid"
      }, HTTP::Status::BAD_REQUEST)
    end

    customer = CustomerQuery.new
      .id(cid)
      .with_soft_deleted
      .first?
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
