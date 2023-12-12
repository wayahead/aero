class Api::Users::Activate < ApiAction
  include Api::Auth::RequireAdmin

  put "/users/activate/:user_id" do
    user = UserQuery.new
      .id(user_id)
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
      activated_user = ActivateUser.update!(user)
      json UserSerializer.new(activated_user)
    end
  end
end
