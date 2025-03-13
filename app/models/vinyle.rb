class Vinyle < ApplicationRecord
  belongs_to :user
  has_many :primary_vinyles, class_name: "Vinyle", foreign_key: "vinyle1_id"
  has_many :secondary_vinyles, class_name: "Vinyle", foreign_key: "vinyle2_id"

  validates :title, :artist, :quality, :year, :presence => true
  validates :description, presence: { message: "Ne peut pas être vide" }
  validates :title, presence: { message: "Ne peut être vide"}
  validates :artist, presence: { message: "Ne peut être vide"}
  validates :year, presence: { message: "Ne peut être vide"}
  # TODO : Available

end
