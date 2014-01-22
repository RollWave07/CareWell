class Task < ActiveRecord::Base
  belongs_to :user
  # belongs_to :group
  belongs_to :assignee, :class_name => "User"
  belongs_to :location
  has_many :updates

  # validates :category, :inclusion => ['getting places', 'around the home', 'shopping', 'meals', 'personal care', 'odds & ends', 'visits & outings']
  validates :title, presence: true


  scope :completed_recently, lambda {where(task_date:(1.day.ago..Time.now))}

  scope :last_month, lambda {where(task_date:(31.day.ago..Time.now))}
  scope :last_week, lambda {where(task_date:(7.day.ago..Time.now))}

  scope :next_month, lambda {where(task_date:(Time.now..Time.now+31.day))}
  scope :next_week, lambda {where(task_date:(Time.now..Time.now+7.day))}

  scope :all_time, lambda {where(task_date:(Time.new(2014, 1, 1)..Time.now))}

  # potentially create a model method to return all tasks here, to be called in view.
  #concerned this may be a group model method, however.
  # def find_group_tasks
  #   Task.joins(:user).where(:users => {group_id: 1})
  # end

  def ordered_updates
    self.updates.order("created_at")
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
  def self.tasks(group)
    #finds where users are in a group and where assignee is not nil
    self.joins(:user).where(:users => {group_id: group}).where.not(assignee_id: nil)
  end

  # def self.top_three_members(tasks)
    
  # end
  def self.next_three_tasks(tasks)
    tasks.limit(3).order(:task_date)
  end
  def self.last_three_tasks(tasks)
    tasks.limit(3).order(:task_date).reverse_order
  end


  def self.top_three_members(tasks)
    top_three(sort_by_value(format_name(tasks_per_member(tasks))))
  end

  # def self.tasks_per_criteria(tasks, criteria)
  #   memberstats = {}
  #   tasks.each do |task|
  #     if memberstats[task.criteria]
  #       memberstats[task.criteria] += 1
  #     else
  #       memberstats[task.criteria] = 1
  #     end
  #   end
  #   memberstats
  # end

  def self.tasks_per_member(tasks)
    memberstats = {}
    tasks.each do |task|
      if memberstats[task.assignee]
        memberstats[task.assignee] += 1
      else
        memberstats[task.assignee] = 1
      end
    end
    memberstats
  end

  def self.format_name(hash)
    hash.map { |k, v| k="#{k.first_name} #{k.last_name}", v }
  end

  def self.format_date(date)
    date.strftime("%a, %b %d")
  end

  def self.sort_by_value(hash)
    hash.sort_by { |a, b| b }
  end

  def self.top_three(value)
    i=0
    the_top_three = []
    while i<3
      the_top_three << value[i] if value[i]
      i+=1
    end
    the_top_three
  end



end
