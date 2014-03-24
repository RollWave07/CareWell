class UserParameterSanitizer < Devise::ParameterSanitizer

  private

  def account_update
  default_params.permit(:first_name, :last_name, :email, :password, :group_id, :password_confirmation, :current_password)
  end

  def sign_up_params
  default_params.permit(:first_name, :last_name, :email, :password, :group_id, :password_confirmation, :current_password)
  end

end
