class SessionsController < ApplicationController
  
  def new
    # POST /login => Sessions#create
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])  # User object or false
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invarid email/password combination'
      render 'new'
    end
  end
  
  # DELETE /logout
  def destroy
    log_out
    redirect_to root_url
  end
end
