module Api::Access::Helpers
  # The 'memoize' macro makes sure only one query is issued to find the user
  memoize def current_user? : User?
    access_token.try do |value|
      user_from_access_token(value)
    end
  end

  private def access_token : String?
    enabler_token || token_param
  end

  private def enabler_token : String?
    context.request.headers["Authorization"]?
      .try(&.gsub("Enabler", ""))
      .try(&.strip)
  end

  private def token_param : String?
    params.get?(:access_token)
  end

  private def user_from_access_token(token : String) : User?
    AccessToken.decode_user_id(token).try do |user_id|
      UserQuery.new.id(user_id).status("activated").first?
    end
  end
end
