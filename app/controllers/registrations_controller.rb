class RegistrationsController < Devise::RegistrationsController

  def join
    @group = Group.find(params[:group_id])
    build_resource(sign_up_params)
    # resource.group = @group
  end

  def after_sign_up_path_for(resource)
    # if resource.group
      group_tasks_path(resource.group)
    # else
    #   new_group_path
    # end
  end

  def update
    @group = current_user.group
    redirect_to group_tasks_path(@group)
  end

  def edit
    @group = current_user.group

     # for menu dashboard
    @assigned_tasks = Task.assigned(@group)
    @counts_arrays = Task.count_per_period(@assigned_tasks)
    @duration_week = Task.duration_total_past_week(@assigned_tasks)
  end

  def after_inactive_sign_up_path_for(resource)
    unauthenticated_root_path(resource)
  end

  def create
    build_resource(sign_up_params)
    new_group = params[:group_name].to_s.downcase.capitalize
    if params[:user][:group_id]
      @group = Group.find(params[:user][:group_id])
    elsif params[:group_name]
      @group = Group.where(name: params[:group_name]).create
    end

    resource.group = @group

    if resource.save
      ServiceSignup.welcome(resource.group, resource).deliver
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
      # respond_with resource
      #would like to set and return an error message but unsure how.
      redirect_to unauthenticated_root_path
    end
  end

end

