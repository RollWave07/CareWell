class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignee, :class_name => "User"
  belongs_to :location
end
