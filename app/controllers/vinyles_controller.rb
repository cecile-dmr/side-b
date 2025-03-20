class VinylesController < ApplicationController
  before_action :set_vinyle, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]


  def new
    @vinyle = Vinyle.new
  end

  def show
    @vinyle = Vinyle.find(params[:id])
    @match = Match.new
  end

  def create
    @vinyle = Vinyle.new(vinyle_params)
    @vinyle.user = current_user
    if @vinyle.save
      redirect_to vinyle_path(@vinyle)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @vinyle.update(vinyle_params)
      redirect_to @vinyle
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vinyle = Vinyle.find(params[:id])
    
    @vinyle.destroy
    redirect_to profile_path(current_user)
  end

  private

  def set_vinyle
    @vinyle = Vinyle.find(params[:id])
  end

  def vinyle_params
    params.require(:vinyle).permit(:title, :artist, :year, :description, :quality, :available, :photo)
  end

  def authorize_user!
    unless @vinyle.user == current_user
      redirect_to root_path, alert: "Tu n'as pas l'autorisation d'effectuer cette action."
    end
  end

end
