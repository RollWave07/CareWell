class MailerInvitation < ActionMailer::Base
  default from: "hello@carewelldesign.com"

  def event(task, group_id)
  # assignee information (from task)
    @first_name = task.assignee.first_name
    @last_name = task.assignee.last_name
    @email  = task.assignee.email
  #task information
    @task = task
    @task_title = task.title
    @task_category = task.category
    @task_information = task.information
    @task_date = task.task_date.strftime('%A, %B %e, %Y')
  #group information
    @group = group_id
  #email content/body information
    @subject_line = "New CareWell Task: #{@task_title}"
    @greeting = "Hi " + task.assignee.first_name + ','
    attachments['event.ics'] = {:mime_type => 'text/calendar', :content => create_ical }
    mail( to: @email, subject: @subject_line)
  end

  def create_ical
     ical = Icalendar::Calendar.new
     e = Icalendar::Event.new
     e.start = (@task.start_time).utc
     e.start.icalendar_tzid="UTC" # set timezone as "UTC"
     e.end = (@task.start_time + @task.duration.to_i.minutes).utc
     e.end.icalendar_tzid="UTC"
     e.organizer "#{@task.user.first_name}"
     #might need uid but maybe not.  test.
     e.uid "CW Task #{@task.id}"
     e.summary @subject_line
     e.description "@task.information"
     ical.add_event(e)
     ical.publish
     ical.to_ical
  end

end
