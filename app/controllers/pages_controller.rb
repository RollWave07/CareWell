class PagesController < ApplicationController
  skip_before_filter :authenticate_user!
  def welcome
  end

  def about_us
  end
end
