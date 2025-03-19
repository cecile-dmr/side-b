class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @vinyles = @user.vinyles
  end
end
