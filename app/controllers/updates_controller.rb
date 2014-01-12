class UpdatesController < ApplicationController
  before_action :authenticate_user!
  def index
    @updates = current_user.updates
    @commenter_name = current_user.first_name
    @commenter_picture = current_user.picture
    @group_name = Group.find(current_user.group_id).name
  end

  def show
  end

  def edit
  end

  def new
  end
end
