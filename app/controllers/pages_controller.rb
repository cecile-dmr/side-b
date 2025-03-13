require "discogs"

class PagesController < ApplicationController
  def swipe
    @vinyles = Vinyle.all.shuffle
  end

  def like
    #on recup le vinyle que l'on a swipe
    current_vinyle = Vinyle.find()

    #on trouve le user a qui appartient se vinyle
    user_of_current_vinyle = Vinyle.find(current_vinyle.user)

    #on regarde si ce user a des "match"
    if user_of_current_vinyle.matchs.each { |match| match.vinyle.user == current_user }
      #creer un match
    end
  end

  def dislike
    vinyle = Vinyle.find()
  end
end
