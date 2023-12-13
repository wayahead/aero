class Api::Accesses::ShowByApp < ApiAction
  get "/accesses/app/:access_app" do
    access = AccessQuery.new
      .app(access_app)
      .user_id(current_user.id)
      .first?
    if access.nil?
      json({
        message: "Not found",
        details: "The access was not found"
      }, HTTP::Status::NOT_FOUND)
    else
      json AccessSerializer.new(access)
    end
  end
end
