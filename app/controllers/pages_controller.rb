require "discogs"

class PagesController < ApplicationController
  def swipe
    @vinyles = Vinyle.not_liked_or_disliked_by(current_user)
  end

  def like
    #on recup le vinyle que l'on a swipe
    current_vinyle = Vinyle.find(id)

    #on trouve le user a qui appartient se vinyle
    user_of_current_vinyle = User.find(current_vinyle.user_id)

    #on regarde si ce user a des "match"
    if user_of_current_vinyle.matchs.each { |match| match.vinyle.user == current_user }
      #creer un match
    end
  end

  # def dislike
  #   vinyle = Vinyle.find()
  # end
end
