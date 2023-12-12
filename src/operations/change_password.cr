class ChangePassword < User::SaveOperation
  param_key :user
  include PasswordValidations

  attribute password : String
  attribute password_confirmation : String

  before_save do
    Authentic.copy_and_encrypt(password, to: encrypted_password) if password.valid?
  end
end
