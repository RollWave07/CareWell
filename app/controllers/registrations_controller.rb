class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    if resource.group
      root_url
    else
      new_group_path
    end
  end

  def create
    super
    @group = Group.create(name: params[:group_name])
    resource.group = @group
    resource.save
  end

  # def after_sign_in_path_for(resource)
  #   group_tasks_path(current_user.group.id)
  # end

end

