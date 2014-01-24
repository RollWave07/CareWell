class Task < ActiveRecord::Base

  belongs_to :user
  # belongs_to :group
  belongs_to :assignee, :class_name => "User"
  belongs_to :location
  has_many :updates

  # validates :category, :inclusion => ['getting places', 'around the home', 'shopping', 'meals', 'personal care', 'odds & ends', 'visits & outings']
  validates :title, presence: true


  scope :completed_recently, lambda {where(task_date:(1.day.ago..Time.now))}

  # potentially create a model method to return all tasks here, to be called in view.
  #concerned this may be a group model method, however.
  # def find_group_tasks
  #   Task.joins(:user).where(:users => {group_id: 1})
  # end

  def ordered_updates
    self.updates.order("created_at")
  end

  def likes_count
    total = 0
    self.updates.each do |update|
      total += update.likes.count
    end
    total
  end

  ## potential model method
  # def needs_assignee
  #   if self.assignee_id.nil? && self.user_id == current_user.id
  #   return "Invite A Helper"
  #   elsif self.assignee_id.nil?
  #   return "I can do this!"
  #   else
  #   return "This is assigned to you."
  #   end
  # end

end
