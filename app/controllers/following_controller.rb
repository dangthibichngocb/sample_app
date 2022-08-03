class FollowingController < ApplicationController
  before_action :logged_in_user, :find_user, only: :index

  def index
    @title = t ".following"
    @pagy, @users = pagy @user.following, items: Settings.item_follow
    render "users/show_follow"
  end
end
