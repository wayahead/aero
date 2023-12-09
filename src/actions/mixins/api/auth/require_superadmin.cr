module Api::Auth::RequireSuperAdmin
  macro included
    before require_superadmin
  end

  private def require_superadmin
    if current_user.superadmin?
      continue
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
