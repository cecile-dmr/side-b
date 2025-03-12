class Vinyle < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, :artist, :year, :description, presence: true
end
