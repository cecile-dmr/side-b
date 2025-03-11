class Vinyle < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :titre, :artiste, :annee, :description, :address, presence: true
end
