class CreateCustomer < Customer::SaveOperation
  param_key :customer
  include DescriptionValidations

  permit_columns name
  permit_columns status
  permit_columns description

  before_save do
    if status.value.nil?
      status.value = "activated"
    else
      status.value = status.value.as(String).downcase
    end

    validate_uniqueness_of name, message: "already existed"
  end
end
