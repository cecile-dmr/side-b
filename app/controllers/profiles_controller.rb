class ProfilesController < ApplicationController

  def show
    @profile = current_user
    @vinyles = current_user.vinyles
  end
end
