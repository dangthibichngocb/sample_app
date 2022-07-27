class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by params[:id]
    return if @user

    flash[:danger] = t ".alert_not_found"
    redirect_to signup_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t ".alert_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".alert_err_create"
      render :new
    end
  end

  def user_params
    params.require(:user).permit(User::USER_ATTR)
  end
end
