module CustomerFromName
  private def customer_from_name : Customer?
    name.value.try do |value|
      CustomerQuery.new.name(value).first?
    end
  end
end
