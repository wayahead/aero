class Api::Accesses::DeleteByApp < ApiAction
  delete "/accesses/app/:access_app" do
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
      deleted_access = DeleteAccess.delete!(access)
      json AccessSerializer.new(deleted_access)
    end
  end
end
