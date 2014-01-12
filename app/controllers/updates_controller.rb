class UpdatesController < ApplicationController
  before_action :authenticate_user!
  def index
    @updates = Update.all
  end

  def show
  end

  def edit
  end

  def new
  end
end
