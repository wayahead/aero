class Api::Accesses::Index < ApiAction
  get "/accesses" do
    access_id = params.get?(:access_id)
    access_app = params.get?(:access_app)
    access_pattern = params.get?(:access_pattern)

    if !access_id.nil?
      aid = UUID.parse?(access_id)
      if aid.nil?
        return json({
          message: "Invalid access id",
          details: "The access id is not valid"
        }, HTTP::Status::BAD_REQUEST)
      else
        access = AccessQuery.new
          .id(aid)
          .user_id(current_user.id)
          .first?
        if access.nil?
          return json({
            message: "Not found",
            details: "The access was not found"
          }, HTTP::Status::NOT_FOUND)
        else
          return json AccessSerializer.new(access)
        end
      end
    elsif !access_app.nil?
      access = AccessQuery.new
        .app(access_app)
        .user_id(current_user.id)
        .first?
      if access.nil?
        return json({
          message: "Not found",
          details: "The access app was not found"
          }, HTTP::Status::NOT_FOUND)
      else
        return json AccessSerializer.new(access)
      end
    elsif !access_pattern.nil?
      pages, accesses = paginate(AccessQuery.new
        .app.like(access_pattern)
        .user_id(current_user.id)
      )
      return json AccessSerializer.for_collection(accesses, pages)
    else
      pages, accesses = paginate(AccessQuery.new
        .user_id(current_user.id)
      )
      return json AccessSerializer.for_collection(accesses, pages)
    end
  end
end
