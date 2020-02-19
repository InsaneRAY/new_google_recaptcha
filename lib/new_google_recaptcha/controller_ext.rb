module NewGoogleRecaptcha
  module ControllerExt
    def block_invalid_recaptcha
      is_valid = NewGoogleRecaptcha::Validator.new(
        token: params[:new_recaptcha_token],
        minimum_score: NewGoogleRecaptcha.minimum_score
      ).call
      redirect_back(fallback_location: root_path) unless is_valid
    end
  end
end
