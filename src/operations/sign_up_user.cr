class SignUpUser < User::SaveOperation
  param_key :user
  # Change password validations in src/operations/mixins/password_validations.cr
  include PasswordValidations
  include UserFromName

  permit_columns name
  permit_columns email
  attribute password : String
  attribute password_confirmation : String
  attribute customer : String

  before_save validate_customer

  before_save do
    # set required fields which are not from request params
    status.value = "created"
    roles.value = [] of String

    validate_uniqueness_of name, message: "already existed"
    validate_uniqueness_of email, message: "already existed"
    Authentic.copy_and_encrypt(password, to: encrypted_password) if password.valid?
  end

  private def validate_customer
    unless customer.value.nil?
      c = CustomerQuery.new.name(customer.value.not_nil!).first?
      if c.nil?
        customer.add_error "not found"
      elsif !c.active?
        customer.add_error "not activated"
      else
        customer_id.value = c.id
      end
    end
  end 
end
