class UpdateCustomer < Customer::SaveOperation
  param_key :customer
  include DescriptionValidations

  permit_columns name
  permit_columns status
  permit_columns description
  permit_columns preferences

  before_save do
    unless status.value.nil?
      status.value = status.value.as(String).downcase
      soft_deleted_at.value = nil
    end

    validate_uniqueness_of name, message: "already existed"
  end
end
