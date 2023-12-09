module Api::Auth::RequireAdmin
  macro included
    before require_admin
  end

  private def require_admin
    if current_user.admin?
      continue
    else
      json auth_denied_json, HTTP::Status::FORBIDDEN
    end
  end

  private def auth_denied_json
    ErrorSerializer.new(
      message: "Permission denied",
      details: "The administrator is required"
    )
  end
end
