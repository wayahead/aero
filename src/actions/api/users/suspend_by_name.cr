class Api::Users::SuspendByName < ApiAction
  include Api::Auth::RequireAdmin

  put "/users/name/suspend/:user_name" do
    user = UserQuery.new
      .name(user_name)
      .with_soft_deleted
      .first?
    if user.nil?
      json({
        message: "Not found",
        details: "The user is not found"
      }, HTTP::Status::NOT_FOUND)
    else
      unless current_user.superadmin?
        unless user.customer_id == current_user.customer_id
          return json({
            message: "Permission denied",
            details: "The administrator is not responsible for user"
          }, HTTP::Status::FORBIDDEN)
        end
      end

      # The named parameter `customer_id` is transferred to operation so
      # you can use `permit_columns customer_id` to save to model, which
      # causes no necessary to transfer `current_user` to operation.
      suspended_user = SuspendUser.update!(user)
      json UserSerializer.new(suspended_user)
    end
  end
end
