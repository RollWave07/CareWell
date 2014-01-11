class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    if current_user.group
      root_url
    else
      new_group_path
    end 
  end

  def after_sign_in_path_for(user)
    group_tasks_path(user.group)
  end

end 

