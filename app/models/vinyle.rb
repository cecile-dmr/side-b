class Vinyle < ApplicationRecord
  belongs_to :user

  validates :title, :artist, :description, :available, :quality, :year, :presence => true
end
