class Api::Users::IndexWithDeleted < ApiAction
  include Api::Auth::RequireAdmin

  get "/users_with_deleted" do
    user_id = params.get?(:user_id)
    user_name = params.get?(:user_name)
    user_pattern = params.get?(:user_pattern)

    if current_user.superadmin?
      if !user_id.nil?
        find_by_id(user_id)
      elsif !user_name.nil?
        find_by_name(user_name)
      elsif !user_pattern.nil?
        pages, users = paginate(UserQuery.new
          .name.like(user_pattern)
          .with_soft_deleted)
        json UserSerializer.for_collection(users, pages)
      else
        # pages, users = paginate(UserQuery.new, per_page: 2)
        pages, users = paginate(UserQuery.new.with_soft_deleted)
        json UserSerializer.for_collection(users, pages)
      end
    else
      if !user_id.nil?
        find_by_id(user_id, current_user.customer_id)
      elsif !user_name.nil?
        find_by_name(user_name, current_user.customer_id)
      elsif !user_pattern.nil?
        if current_user.customer_id.nil?
          pages, users = paginate UserQuery.new
            .name.like(user_pattern)
            .customer_id.is_nil
            .with_soft_deleted
            .roles.not.includes("superuser")
          json UserSerializer.for_collection(users, pages)
        else
          pages, users = paginate UserQuery.new
            .name.like(user_pattern)
            .customer_id(current_user.customer_id.not_nil!)
            .with_soft_deleted
            .roles.not.includes("superuser")
          json UserSerializer.for_collection(users, pages)
        end
      else
        if current_user.customer_id.nil?
          pages, users = paginate UserQuery.new
            .customer_id.is_nil
            .with_soft_deleted
            .roles.not.includes("superuser")
          json UserSerializer.for_collection(users, pages)
        else
          pages, users = paginate UserQuery.new
            .customer_id(current_user.customer_id.not_nil!)
            .with_soft_deleted
            .roles.not.includes("superuser")
          json UserSerializer.for_collection(users, pages)
        end
      end
    end
  end

  private def find_by_id(user_id : String)
    uid = UUID.parse?(user_id)
    if uid.nil?
      json({
        message: "Invalid user id",
        details: "The user id is not valid"
      }, HTTP::Status::BAD_REQUEST)
    else
      user = UserQuery.new
        .id(uid)
        .with_soft_deleted
        .first?
      if user.nil?
        json({
          message: "Not found",
          details: "The user was not found"
        }, HTTP::Status::NOT_FOUND)
      else
        json UserSerializer.new(user)
      end
    end
  end

  private def find_by_id(user_id : String, customer_id : UUID?)
    uid = UUID.parse?(user_id)
    if uid.nil?
      json({
        message: "Invalid user id",
        details: "The user id is not valid"
      }, HTTP::Status::BAD_REQUEST)
    else
      user = if customer_id.nil?
        UserQuery.new
          .id(uid)
          .customer_id.is_nil
          .with_soft_deleted
          .roles.not.includes("superuser")
          .first?
      else
        UserQuery.new
          .id(uid)
          .customer_id(customer_id.not_nil!)
          .with_soft_deleted
          .roles.not.includes("superuser")
          .first?
      end

      if user.nil?
        json({
          message: "Not found",
          details: "The user was not found"
        }, HTTP::Status::NOT_FOUND)
      else
        json UserSerializer.new(user)
      end
    end
  end

  private def find_by_name(user_name : String)
    puts "find by name"
    user = UserQuery.new
      .name(user_name)
      .with_soft_deleted
      .first?
    if user.nil?
      json({
        message: "Not found",
        details: "The user was not found"
        }, HTTP::Status::NOT_FOUND)
    else
      json UserSerializer.new(user)
    end
  end

  private def find_by_name(user_name : String, customer_id : UUID?)
    user = if customer_id.nil?
      UserQuery.new
        .name(user_name)
        .customer_id.is_nil
        .with_soft_deleted
        .roles.not.includes("superuser")
        .first?
    else
      UserQuery.new
        .name(user_name)
        .customer_id(customer_id.not_nil!)
        .with_soft_deleted
        .roles.not.includes("superuser")
        .first?
      end

    if user.nil?
      json({
        message: "Not found",
        details: "The user was not found"
        }, HTTP::Status::NOT_FOUND)
    else
      json UserSerializer.new(user)
    end
  end
end
