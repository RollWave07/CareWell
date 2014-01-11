class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignee, :class_name => "User"
  belongs_to :location

  validates :category, :inclusion => ['getting places', 'around the home', 'shopping', 'meals', 'personal care', 'odds & ends', 'visits & outings']

  # potentially create a model method to return all tasks here, to be called in view.
  #concerned this may be a group model method, however.
  # def find_group_tasks
  #   Task.joins(:user).where(:users => {group_id: 1})
  # end

end
