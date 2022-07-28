class InvitationsController < ApplicationController

  def index
    @invites_sended = Invitation.invites_sended(current_user)
    @invites_received = Invitation.invites_received(current_user)
  end
  

  def create
    @invite = Invitation.new(invitations_params)
    respond_to do |format|
      if @invite.save
        format.html { redirect_to request.referrer, notice: 'Convite enviado com sucesso!' }
        format.json { render :show, status: :created, location: @invite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invite = Invitation.find(params[:id])
    @invite.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Convite desfeito com sucesso!' }
      format.json { head :no_content }
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invited
    @invited = Invitation.find(params[:event_id,:invited_user_id,:sender_id])
  end

  private
  def invitations_params
    params.permit(:invited_user_id, :event_id, :sender_id)
  end
end
