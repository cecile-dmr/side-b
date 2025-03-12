require "discogs"

class PagesController < ApplicationController
  def swipe
    @vinyles = Vinyle.all.shuffle
  end
end
