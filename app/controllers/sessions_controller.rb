class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash[:notice] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    user = current_user
    log_out user if user
    redirect_to root_url
  end
end
