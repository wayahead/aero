class Api::Customers::Index < ApiAction
  get "/customers" do
    if current_user.superadmin?
      # pages, customers = paginate(CustomerQuery.new, per_page: 2)
      pages, customers = paginate(CustomerQuery.new)
      json CustomerSerializer.for_collection(customers, pages)
    else
      json auth_denied_json, HTTP::Status::FORBIDDEN
    end
  end

  private def auth_denied_json
    ErrorSerializer.new(
      message: "Permission denied",
      details: "The superadmin is required"
    )
  end
end
