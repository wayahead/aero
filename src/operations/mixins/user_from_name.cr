module UserFromName
  private def user_from_name : User?
    name.value.try do |value|
      UserQuery.new.name(value).first?
    end
  end
end
