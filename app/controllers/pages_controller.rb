require "discogs"

class PagesController < ApplicationController

  def swipe
    @user = current_user
    @vinyles = Vinyle.not_liked_or_disliked_by(current_user).shuffle
  end

  # def swipe
  #   if current_user.latitude && current_user.longitude
  #     @vinyles = User.near([current_user.latitude, current_user.longitude], current_user.search_radius)
  #     .vinyles
  #     .left_joins(:user_likes, :user_dislikes)
  #     .where.not(user_likes: { user_id: current_user.id })
  #     .where.not(user_dislikes: { user_id: current_user.id })
  #   else
  #     @vinyles = Vinyle.not_liked_or_disliked_by(current_user)
  #   end
  # end

  def update_radius
    respond_to do |format|
      format.json do
        if current_user.update(search_radius: params[:radius])
          @vinyles = Vinyle.not_liked_or_disliked_by(current_user)
          flash[:notice] = "Rayon de recherche mis à jour !"
          # redirect_to root_path # Rediriger vers la vue principale
            render json: {
            message: "Rayon de recherche mis à jour !",
            search_radius: current_user.search_radius,
            cards: render_to_string(partial: "shared/card_vinyle", collection: @vinyles, as: :vinyles, formats: [:html])
            }, status: :ok
        end
      end
      flash[:alert] = "Erreur lors de la mise à jour."
      # redirect_to root_path
    end
  end

  # def perimetre
  #   @search_radius = current_user.update(search_radius: params[:search_radius])
  # end

  # def like
  #   #on recup le vinyle que l'on a swipe
  #   current_vinyle = Vinyle.find(id)

  #   #on trouve le user a qui appartient ce vinyle
  #   user_of_current_vinyle = User.find(current_vinyle.user_id)

  #   #on regarde si ce user a des "match"
  #   if user_of_current_vinyle.matchs.each { |match| match.vinyle.user == current_user }
  #     #creer un match
  #   end
  # end

  # def nearby_users
  #   User.near([latitude, longitude], search_radius)
  # end

  # def nearby_users_vinyles
  #   User.near([latitude, longitude], search_radius).vinyles
  # end


  # def dislike
  #   vinyle = Vinyle.find()
  # end
end



# <div class="tinder--card" data-action="click->custom-swiper#flip" data-custom-swiper-target="flipper" data-vinyl-id="353" data-user-id="157">
#   <img src="https://res.cloudinary.com/dta7kinov/image/upload/v1/development/tpdisj37rby4p2rlwlyo58rcg5bh?_a=BACAEuEv">
#   <div class="tinder--card--content">
#     <h3>From Here To Eternity</h3>
#     <p>Electronic</p>
#   </div>
# </div>
