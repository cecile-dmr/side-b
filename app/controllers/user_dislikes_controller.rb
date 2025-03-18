class UserDislikesController < ApplicationController
  def create
    user_dislike = UserDislike.new(user_dislike_params)
    user_dislike.vinyle = Vinyle.find(params["vinyl_id"])
    user_dislike.user = current_user
    user_dislike.save
  end

  private

  def user_dislike_params
    params.require(:user_dislike).permit(:user_id, :vinyl_id)
  end
end
