class Update < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  
  acts_as_votable
end
