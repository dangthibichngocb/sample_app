class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]
      remember_user user
    else
      flash.now[:danger] = t ".invalid_email_password"
      redirect_to root_url
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_url
  end

  private
  def remember_user user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or user
  end
end
