class GroupsController < ApplicationController
  protect_from_forgery with: :exception

  end

  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def show
  end

  def edit
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_path, notice: 'group was successfully created.' }
        format.js { render layout: false }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'group was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end
  
  def destroy
    
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end
  def group_params
    params.require(:group).permit(:name)
  end
end
