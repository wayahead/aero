class ResetAccess < Access::SaveOperation
  before_save do
    status.value = "activated"

    key.value = UUID.random.hexstring
    secret.value = UUID.random.hexstring
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