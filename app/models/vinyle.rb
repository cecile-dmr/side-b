class Vinyle < ApplicationRecord
  belongs_to :user
  has_many :primary_vinyles, class_name: "Vinyle", foreign_key: "vinyle1_id"
  has_many :secondary_vinyles, class_name: "Vinyle", foreign_key: "vinyle2_id"

  validates :title, :artist, :quality, :year, :presence => true
  validates :description, presence: { message: "ne peut pas être vide" }
  # TODO : Available

end
