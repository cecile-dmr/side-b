require "discogs"

class PagesController < ApplicationController
  def swipe
    @user = current_user
    @vinyles = Vinyle.not_liked_or_disliked_by(current_user).shuffle
  end

  def update_radius
    respond_to do |format|
      format.json do
        if current_user.update(search_radius: params[:radius])
          @vinyles = Vinyle.not_liked_or_disliked_by(current_user).shuffle
          render json: {
            search_radius: current_user.search_radius,
            cards: render_to_string(partial: "shared/card_vinyle", collection: @vinyles, as: :vinyles,
                                    formats: [:html]),
            show_modal: true # la modal devient true
          }, status: :ok
        end
      end
    end
  end
end
