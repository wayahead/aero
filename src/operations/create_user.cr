class CreateUser < User::SaveOperation
  param_key :user
  # Change password validations in src/operations/mixins/password_validations.cr
  include PasswordValidations
  include DescriptionValidations

  permit_columns name
  permit_columns email
  permit_columns status
  permit_columns roles
  permit_columns description
  permit_columns preferences
  permit_columns customer_id
  attribute password : String
  attribute password_confirmation : String

  before_save do
    if status.value.nil?
      status.value = "activated"
    else
      status.value = status.value.as(String).downcase
    end

    if roles.value.nil?
      roles.value = [] of String
    else
      roles.value = roles.value.as(Array(String)).map &.downcase
    end

    validate_uniqueness_of name, message: "already existed"
    validate_uniqueness_of email, message: "already existed"
    Authentic.copy_and_encrypt(password, to: encrypted_password) if password.valid?
  end

  after_save log_changes

  def log_changes(user : User)
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
