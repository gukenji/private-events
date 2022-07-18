class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @events = Event.all
    @event = Event.new
  end


  def show
  end

  def create
    @event = current_user.events.build(event_params)
  end

  def event_params
    params.require(:event).permit(:date, :local, :name)
  end

end
