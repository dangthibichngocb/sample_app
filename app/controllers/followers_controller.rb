class FollowersController < ApplicationController
  before_action :logged_in_user, :find_user, only: :index

  def index
    @title = t ".followers"
    @pagy, @users = pagy @user.followers, items: Settings.item_follow
    render "users/show_follow"
  end
end
