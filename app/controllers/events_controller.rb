class EventsController < ApplicationController

  before_action :find_group

  def new
    @event = Event.new
  end

  def create

    @event = Event.new(event_params)
    date = Chronic.parse(event_params[:event_date])
    @event.event_date = date
    @event.group_id = @group.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to group_tasks_path(@group), notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new', alert: 'Unable to add the event.  Please try again.' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end



  private

  def find_group
    if current_user.group
      @group = current_user.group
    else
      @group = Group.find(params[:group_id])
    end
  end

  def event_params
    params.fetch(:event, {}).permit(:event_title, :event_details, :event_date, :event_location, :group_id)
   end

end
