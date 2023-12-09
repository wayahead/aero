class Api::Customers::Index < ApiAction
  include Api::Auth::RequireSuperAdmin

  get "/customers" do
    customer_id = params.get?(:customer_id)
    customer_name = params.get?(:customer_name)

    if !customer_id.nil?
      cid = UUID.parse?(customer_id)
      if cid.nil?
        return json({
          message: "Invalid customer id",
          details: "The customer id is not valid"
        }, HTTP::Status::BAD_REQUEST)
      else
        customer = CustomerQuery.new.id(cid).first?
        if customer.nil?
          return json({
            message: "Not found",
            details: "The customer was not found"
          }, HTTP::Status::NOT_FOUND)
        else
          return json CustomerSerializer.new(customer.as(Customer))
        end
      end
    elsif !customer_name.nil?
      customer = CustomerQuery.new.name(customer_name).first?
      if customer.nil?
        return json({
          message: "Not found",
          details: "The customer name was not found"
          }, HTTP::Status::NOT_FOUND)
      else
        return json CustomerSerializer.new(customer.as(Customer))
      end
    else
      # pages, customers = paginate(CustomerQuery.new, per_page: 2)
      pages, customers = paginate(CustomerQuery.new)
      return json CustomerSerializer.for_collection(customers, pages)
    end
  end
end
