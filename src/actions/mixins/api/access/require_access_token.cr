module Api::Access::RequireAccessToken
  macro included
    before require_access_token
  end

  private def require_access_token
    if current_user?
      continue
    else
      json access_error_json, 401
    end
  end

  private def access_error_json
    ErrorSerializer.new(
      message: "Not authenticated",
      details: access_error_details
    )
  end

  private def access_error_details : String
    if access_token
      "The access is not active or token was incorrect"
    else
      # An authentication token is required. Please include a token
      # in an 'access_token' param or 'Authorization' header.
      "The access token was not found"
    end
  end

  # Tells the compiler that the current_user is not nil since we have checked
  # that the user is signed in
  private def current_user : User
    current_user?.as(User)
  end
end
