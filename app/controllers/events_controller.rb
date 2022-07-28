class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @events = Event.all
    @upcoming_events = Event.upcoming_events(current_user)
    # @upcoming_private_events = Event.upcoming_private_events(current_user)
    @past_events = Event.past_events(current_user)
    @event = Event.new
  end

  def new
    @event = current_user.created_events.build
  end

  def show
    @event = Event.find(params[:id])

    if @event.private == true && !Invitation.where(event_id: @event.id,
                                                   invited_user_id: current_user.id).exists? && @event.creator_id != current_user.id
      flash[:alert] = 'Você não tem permissão para ver esse evento'
      redirect_to root_path
    end
  end

  def edit
    @event = Event.find(params[:id])
    @creator = User.find(Event.find(params[:id]).creator_id)
    unless @creator == current_user
      flash[:alert] = 'Você não tem permissão para editar esse evento!'
      redirect_to root_path
    end
  end

  def update
    @event = Event.find(params[:id])
    @creator = User.find(Event.find(params[:id]).creator_id)
    unless @creator == current_user
      flash[:alert] = 'Você não tem permissão para atualizar esse evento!'
      return redirect_to root_path
    end
    @event.update(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_path(@event.id), notice: 'Evento atualizado com sucesso!' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @event = current_user.created_events.build(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_path(@event.id), notice: 'Evento criado com sucesso!' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @creator = User.find(Event.find(params[:id]).creator_id)
    unless @creator == current_user
      flash[:alert] = 'Você não tem permissão para excluir esse evento'
      return redirect_to root_path
    end
    @event.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Evento excluído com sucesso!' }
      format.json { head :no_content }
    end
  end

  private

  def event_params
    params.require(:event).permit(:date, :local, :name, :private)
  end
end
