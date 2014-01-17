class SecureController < ApplicationController

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    [:first_name, :last_name, :phone, :picture, :role, :admin, :notes, :group_id].each do |field|
      devise_parameter_sanitizer.for(:sign_up) << field
      devise_parameter_sanitizer.for(:account_update) << field
    end
  end

end