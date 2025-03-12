class BookingsController < ApplicationController
  def create
    @vinyle = Vinyle.find(params[:vinyle_id])
    @match = Match.new(match_params)
    @match.vinyle = @vinyle
    @match.user = current_user
    if @match.save
      redirect_to @vinyle
    else
      render "vinyles/show"
    end
  end

  def show
    @match = Match.find(params[:id])
    @message = Message.new
  end

  private

  def match_params
    params.require(:match).permit(:date)
  end
end
