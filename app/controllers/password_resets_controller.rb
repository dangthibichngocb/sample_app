class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)
  before_action :find_reset_user, only: :create
  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".email_reset"
      redirect_to root_url
    else
      flash.now[:danger] = t ".email_not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add(:password, t(".cant_empty"))
      render :edit
    elsif @user.update user_params
      log_in @user
      flash[:success] = t ".reset_success"
      redirect_to @user
    else
      flash[:danger] = t ".reset_fail"
      render :edit
    end
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t ".pass_reset"
    redirect_to new_password_reset_url
  end
  private

  def get_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def find_reset_user
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    return if @user

    flash.now[:danger] = t ".email_not_found"
    render :new
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset,
                                                       params[:id])

    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(User::USER_ATTR_PASSWORD_RESET)
  end
end
