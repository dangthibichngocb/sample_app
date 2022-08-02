class UsersController < ApplicationController
  before_action :find_user, except: %i(new create index)
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all, page: params[:page],
      items: Settings.user.index.items
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_mail_activate
      flash[:info] = t ".alert_mail_activate"
      redirect_to login_url
    else
      flash.now[:danger] = t ".alert_err_create"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".alert_success_update"
      redirect_to @user
    else
      flash[:danger] = t ".alert_err_update"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".alert_success_delete"
    else
      flash[:danger] = t ".alert_err_delete"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit User::USER_ATTR
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".login."
    redirect_to login_url
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t ".not_found"
    redirect_to root_url
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".alert_not_found"
    redirect_to signup_path
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
