class UpdateAccess < Access::SaveOperation
  param_key :access
  include DescriptionValidations

  permit_columns app
  permit_columns key
  permit_columns secret
  permit_columns status
  permit_columns description
  permit_columns preferences
  permit_columns user_id

  before_save do
    unless status.value.nil?
      status.value = status.value.as(String).downcase
    end

    validate_uniqueness_of key, message: "already existed"
    validate_uniqueness_of secret, message: "already existed"
  end

  after_save log_changes

  def log_changes(access : Access)
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
