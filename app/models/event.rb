class Event < ActiveRecord::Base
  belongs_to :group

  scope :from_this_month, lambda {where(event_date: Time.now.at_beginning_of_month..Time.now.at_end_of_month)}

  def self.events(group)
    self.where(group_id: group)
  end

end
