# Include modules and add methods that are for all API requests
abstract class ApiAccess < Lucky::Action
  disable_cookies
  accepted_formats [:json], default: :json
  route_prefix "/api/v1"

  include Api::Access::Helpers

  include Api::Access::RequireAccessToken

  include Lucky::EnforceUnderscoredRoute

  include Lucky::Paginator::BackendHelpers

  def paginator_per_page : Int32
    params.get?(:per_page).try(&.to_i) || 50
  end

  def paginator_page : Int32
    request.headers["Page"]?.try(&.to_i) || 1
  end
end
