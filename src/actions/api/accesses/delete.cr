class Api::Accesses::Delete < ApiAction
  delete "/accesses/:access_id" do
    aid = UUID.parse?(access_id)
    if aid.nil?
      return json({
        message: "Invalid access id",
        details: "The access id is not valid"
      }, HTTP::Status::BAD_REQUEST)
    end

    access = AccessQuery.new
      .id(aid)
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
