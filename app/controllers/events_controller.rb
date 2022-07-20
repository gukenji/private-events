class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @events = Event.all
    @event = Event.new
  end

  def new
    @event = current_user.created_events.build
  end

  def show; end

  def create
    @event = current_user.created_events.build(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: 'Evento criado com sucesso!' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def event_params
    params.require(:event).permit(:date, :local, :name)
  end
end
