module DescriptionValidations
  macro included
    before_save run_description_validations
  end

  private def run_description_validations
    validate_size_of description, max: 256
  end
end
