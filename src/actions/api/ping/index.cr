class Api::Ping::Index < ApiAccess
  get "/ping" do
    json({
      message: "Active",
      details: "The service is running"
    }, HTTP::Status::OK)
  end
end
