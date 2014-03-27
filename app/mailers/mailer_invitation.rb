class MailerInvitation < ActionMailer::Base
  default from: "hello@carewelldesign.com"

  require 'icalendar'
  require 'date'

   def calendar_invite(task)
       @subject_line = "New CareWell Task: #{task.title}"
       @organizer = task.user.first_name
        mail(:to => task.assignee.email, :subject => @subject_line,
                     :from => "hello@carewelldesign.com") do |format|
          format.ics {
                 ical = Icalendar::Calendar.new
                 e = Icalendar::Event.new
                 e.start = task.task_date.to_datetime.utc
                 e.start.icalendar_tzid="UTC" # set timezone as "UTC"
                 e.end = (task.task_date + task.duration.to_i.minutes).to_datetime.utc
                 e.end.icalendar_tzid="UTC"
                 e.organizer "#{task.user.email}"
                 e.uid "CW #{task.id}"
                 e.summary "#{task.title}"
                 e.description "#{task.information}"
                 ical.add_event(e)
                 ical.publish
                 ical.to_ical
                 render :text => ical.to_ical, :layout => false
                }
       end
     end

  def task_created(task, user)
    @task = task
    @user = user
    @subject_line = "Task Creation Notification: #{task.title}"
    mail(:to => @user.email, :subject => @subject_line)
  end

  def task_sign_up_notification(task)
    @task = task
    @group = task.group.id
    @user = task.user.first_name
    @subject_line = "Task Sign Up Notification: #{task.assignee.first_name} signed up for #{task.title}"

    mail(:to => @task.user.email, :subject => @subject_line)
  end

  def task_reminder(task)
    @group = task.group_id
    @task = task
    @user = task.assignee
    @subject_line = "Reminder for Your Upcoming Task, #{task.title}!"

    mail(:to => @user.email, :subject => @subject_line)
  end

  def not_covered_upcoming_task(task)
    @group = task.group_id
    @task = task
    @user = task.user
    @subject_line = "Heads Up! #{task.title} is coming up but isn't covered."

    mail(:to => @user.email, :subject => @subject_line)
  end

end
