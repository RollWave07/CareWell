class MailerInvitation < ActionMailer::Base

  require 'icalendar'
  require 'date'

   def calendar_invite(task)
       @subject_line = "New CareWell Task: #{task.title}"
       @organizer = task.user.first_name
        mail(:to => 'bensbigolbeard@gmail.com', :subject => @subject_line,
                     :from => "hello@carewelldesign.com") do |format|
          format.ics {
                 ical = Icalendar::Calendar.new
                 e = Icalendar::Event.new
                 e.start = task.start_time.to_datetime.utc
                 e.start.icalendar_tzid="UTC" # set timezone as "UTC"
                 e.end = (task.start_time + task.duration.to_i.minutes).to_datetime.utc
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

end
