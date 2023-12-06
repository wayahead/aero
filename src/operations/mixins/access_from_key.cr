module AccessFromKey
  private def access_from_key : Access?
    key.value.try do |value|
      AccessQuery.new.key(value).first?
    end
  end
end
