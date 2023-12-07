# Include modules and add methods that are for all API requests
abstract class ApiAction < Lucky::Action
  # APIs typically do not need to send cookie/session data.
  # Remove this line if you want to send cookies in the response header.
  disable_cookies
  accepted_formats [:json], default: :json
  route_prefix "/api/v1"

  include Api::Auth::Helpers

  # By default all actions require sign in.
  # Add 'include Api::Auth::SkipRequireAuthToken' to your actions to allow all requests.
  include Api::Auth::RequireAuthToken

  # By default all actions are required to use underscores to separate words.
  # Add 'include Lucky::SkipRouteStyleCheck' to your actions if you wish to ignore this check for specific routes.
  include Lucky::EnforceUnderscoredRoute

  # Enable pagination
  include Lucky::Paginator::BackendHelpers

  def paginator_per_page : Int32
    # Return a static/default value
    50

    # Or allow using a param with a default
    params.get?(:per_page).try(&.to_i) || 50
  end

  def paginator_page : Int32
    request.headers["Page"]?.try(&.to_i) || 1
  end
end
