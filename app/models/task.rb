class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignee, :class_name => "User"
  belongs_to :location

  validates :category, :inclusion => ['getting places', 'around the home', 'shopping', 'meals', 'personal care', 'odds & ends', 'visits & outings']
end
