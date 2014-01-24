class Task < ActiveRecord::Base

  belongs_to :user
  # belongs_to :group
  belongs_to :assignee, :class_name => "User"
  belongs_to :location
  has_many :updates

  
  validates :title, presence: true


  scope :completed_recently, lambda { where(task_date: 1.day.ago..Time.now) }


  #___GRAPH DATA
  scope :future, lambda {where(["task_date > ?", Time.now])}
  scope :past, lambda {where(["task_date < ?", Time.now])}
  
  scope :week_one, lambda {where(task_date:(7.day.ago..Time.now))}
  scope :week_two, lambda {where(task_date:(14.day.ago..8.day.ago))}
  scope :week_three, lambda {where(task_date:(21.day.ago..15.day.ago))}
  scope :week_four, lambda {where(task_date:(28.day.ago..22.day.ago))}
  
  @scopes_period = ["week_one", "week_two", "week_three", "week_four"]

  def self.count_per_period(tasks, time_period = @scopes_period)
    output_array = []
    time_period.each do |time|
      output_array << tasks.send("#{time}").count
    end
    output_array
  end



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



  def self.tasks(group)
    self.joins(:user).where(:users => {group_id: group})
  end

  #finds 1 month of future tasks
  # this is a test!!
  def self.upcoming_tasks(group)
    tasks = self.joins(:user).where(:users => {group_id: group})
    tasks.where(task_date:(Time.now..Time.now+31.day))
  end

  #finds tasks that are not assigned to an assignee(user)
  def self.unassigned(tasks)
    self.assigned_to_specific_user(tasks, nil)
  end

  def self.assigned_to_specific_user(tasks, user)
    tasks.select do |task|
      task.assignee == user
    end
  end

  # def self.assigned(tasks)
  #   tasks.select do |task|
  #     task.assignee != nil
  #   end
  # end

  #this needs to be different so that the scope works
  def self.assigned(group)
    Task.tasks(group).where.not(assignee_id: nil)
  end
  def self.last_three_tasks_completed(tasks)
    tasks.limit(3).where(task_date: 1.month.ago..Time.now).order(task_date: :desc)
  end

  def self.average_duration_per_category(tasks)
    tasks.group(:category).select(:category, :duration).average(:duration)
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



  




  # def self.top_three_members(tasks)
  #   top_three(sort_by_value(format_name(tasks_per_member(tasks))))
  # end
  #INFO: does not work but might be a good start to refactor
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



  #OLD SORTING METHOD:
  #UNTESTED CHANGES took out assignee
  # def self.tasks_per_member(tasks)
  #   memberstats = {}
  #   tasks.each do |task|
  #     if memberstats[task.assignee]
  #       memberstats[task] += 1
  #     else
  #       memberstats[task] = 1
  #     end
  #   end
  #   memberstats
  # end

  # #UNTESTED CHANGES added assignee
  # def self.format_name(hash)
  #   hash.map { |k, v| k="#{k.assignee.first_name} #{k.assignee.last_name}", v }
  # end

  # def self.format_date(date)
  #   date.strftime("%a, %b %d")
  # end

  # def self.sort_by_value(hash)
  #   hash.sort_by { |a, b| b }
  # end

  # def self.top_three(value)
  #   i=0
  #   the_top_three = []
  #   while i<3
  #     the_top_three << value[i] if value[i]
  #     i+=1
  #   end
  #   the_top_three
  # end


  #OLD STUFF --------------
  # validates :category, :inclusion => ['getting places', 'around the home', 'shopping', 'meals', 'personal care', 'odds & ends', 'visits & outings']
  # scope :last_month, lambda {where(task_date:(31.day.ago..Time.now))}
  # scope :last_week, lambda {where(task_date:(7.day.ago..Time.now))}
  # scope :next_month, lambda {where(task_date:(Time.now..Time.now+31.day))}
  # scope :next_week, lambda {where(task_date:(Time.now..Time.now+7.day))}
  # scope :all_time, lambda {where(task_date:(Time.new(2014, 1, 1)..Time.now))}

  # potentially create a model method to return all tasks here, to be called in view.
  #concerned this may be a group model method, however.
  # def find_group_tasks
  #   Task.joins(:user).where(:users => {group_id: 1})
  # end




end
