class VinylesController < ApplicationController
  before_action :set_vinyle, only: [:show, :edit, :update, :destroy]

  def index
    @vinyles = Vinyle.all
  end

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
      redirect_to vinyle_path(@vinyle), notice: "Vinyle ajouté avec succès."
    else
      flash.now[:alert] = "Erreur lors de l'ajout du vinyle. Veuillez vérifier les informations."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @vinyle.update(vinyle_params)
      redirect_to @vinyle, notice: "Vinyle mis à jour avec succès."
    else
      flash.now[:alert] = "Erreur lors de la mise à jour du vinyle."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @vinyle.destroy
    redirect_to vinyle_path, notice: "Vinyle supprimé avec succès."
  end

  private

  def set_vinyle
    @vinyle = Vinyle.find(params[:id])
  end

  def vinyle_params
    params.require(:vinyle).permit(:title, :artist, :year, :description, :quality, :available)
  end
end
