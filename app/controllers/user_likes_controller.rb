class UserLikesController < ApplicationController
  def create
    user_like = UserLike.new(user_like_params)
    user_like.vinyle = Vinyle.find(params["vinyl_id"])
    user_like.user = current_user
    user_like.save
  end

  private

  def user_like_params
    params.require(:user_like).permit(:user_id, :vinyl_id)
  end
end
