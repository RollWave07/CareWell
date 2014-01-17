class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    # if resource.group
      group_tasks_path(resource.group)
    # else
    #   new_group_path
    # end
  end

  def create
    build_resource(sign_up_params)
    new_group = params[:group_name].to_s.downcase.capitalize
    if params[:group_id]
      @group = Group.find(params[:group_id])
    elsif params[:group_name]
      @group = Group.where(name: params[:group_name]).create
    end

    resource.group = @group

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # def after_sign_in_path_for(resource)
  #   group_tasks_path(current_user.group.id)
  # end

end

