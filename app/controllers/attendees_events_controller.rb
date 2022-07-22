class AttendeesEventsController < ApplicationController

  
  def create
    @attendee_events = AttendeesEvent.new(attendees_events_params)
    respond_to do |format|
      if @attendee_events.save
        format.html { redirect_to event_path(@attendee_events.event_id), notice: 'Você se inscreveu com sucesso!' }
        format.json { render :show, status: :created, location: @attendee_events }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendee_events.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendee_events = AttendeesEvent.find(params[:id])
    @attendee_events.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@attendee_events.event_id), notice: 'Você saiu do evento!' }
      format.json { head :no_content }
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attendee_event
    @attendee_event = AttendeesEvent.find(params[:event_id,:attendee_id])
  end

  private
  def attendees_events_params
    params.permit(:attendee_id, :event_id)
  end
end
