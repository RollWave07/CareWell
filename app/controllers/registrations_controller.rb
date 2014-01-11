class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    if current_user.group
      root_url
    else
      new_group_path
    end 
  end

end 

