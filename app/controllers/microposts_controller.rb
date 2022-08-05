class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :find_micropost, only: :destroy
  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = t ".create_alert_success"
      redirect_to root_url
    else
      not_create
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".del_alert_success"
    else
      flash[:danger] = t ".del_alert_err"
    end
    redirect_to request.referer || root_url
  end
  private
  def micropost_params
    params.require(:micropost).permit Micropost::MICRO_ATTR
  end

  def find_micropost
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t ".not_found"
    redirect_to root_url
  end

  def not_create
    flash.now[:danger] = t ".create_alert_err"
    @pagy, @feed_items = pagy current_user.feed.newest
    render "static_pages/home"
  end
end
