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

  after_save log_changes

  def log_changes(customer : Customer)
    # Get changed attributes and log each of them
    attributes.select(&.changed?).each do |attribute|
      Log.dexter.info do
        {
          changed_attribute: attribute.name.to_s,
          from: attribute.original_value.to_s,
          to: attribute.value.to_s
        }
      end
    end
  end
end
