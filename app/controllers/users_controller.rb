class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.order("name ASC").all
    @events = @user.created_events
    if !(@user == current_user)
      flash[:alert] = "Você não tem permissão para ver esse usuário"
      redirect_to root_path
    end
  end
end
