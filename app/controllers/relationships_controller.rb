class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user_by_followed, only: :create
  before_action :find_followed_by_id, only: :destroy

  def create
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private
  def find_user_by_followed
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t ".danger_follow"
    redirect_to root_path
  end

  def find_followed_by_id
    relation_ship = Relationship.find_by(id: params[:id])
    @user = relation_ship.followed if relation_ship
    return if @user

    flash[:danger] = t ".danger_unfollow"
    redirect_to root_path
  end
end
