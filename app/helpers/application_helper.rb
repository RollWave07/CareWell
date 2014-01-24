module ApplicationHelper

  def nav_links_class(page, controller)
    " active" if page == params['action'] && params[:controller] == controller
  end

end
