class Vinyle < ApplicationRecord
  belongs_to :user
  has_many :primary_vinyles, class_name: "Vinyle", foreign_key: "vinyle1_id"
  has_many :secondary_vinyles, class_name: "Vinyle", foreign_key: "vinyle2_id"
  has_many :user_likes
  has_many :user_dislikes

  validates :quality, :presence => true
  validates :description, presence: { message: "Ne peut pas être vide" }
  validates :title, presence: { message: "Ne peut être vide"}
  validates :artist, presence: { message: "Ne peut être vide"}
  validates :year, presence: { message: "Ne peut être vide"}
  # TODO : Available

  scope :not_liked_or_disliked_by, ->(user) {
    liked_ids = UserLike.where(user: user).pluck(:vinyle_id)
    disliked_ids = UserDislike.where(user: user).pluck(:vinyle_id)

    where.not(user: user).where.not(id: liked_ids + disliked_ids)
  }
end
