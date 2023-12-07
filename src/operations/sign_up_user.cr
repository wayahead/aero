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
    validate_uniqueness_of name, message: "already existed"
    validate_uniqueness_of email, message: "already existed"
    Authentic.copy_and_encrypt(password, to: encrypted_password) if password.valid?

    # set required fields which are not from request params
    status.value = "created"
    roles.value = [] of String
  end

  private def validate_customer
    unless customer.value.nil?
      puts customer.value.not_nil!
      org = CustomerQuery.new.name(customer.value.not_nil!).first?
      if !org.nil?
        customer_id.value = org.id
      else
        customer.add_error "not found"
      end
    end
  end 
end
