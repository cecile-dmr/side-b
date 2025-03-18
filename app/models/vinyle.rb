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

    # retourne un array avec tous les users dans le périmètre
    users_in_radius = User.near([user.latitude, user.longitude], 50).pluck(:id)

    # retourne tous les vinyles des users qui sont dans le périmètres
    # vinyles_in_radius = Vinyle.where(id: users_in_radius)


    liked_ids = UserLike.where(user: user).pluck(:vinyle_id)
    disliked_ids = UserDislike.where(user: user).pluck(:vinyle_id)

    # where.not(user: user).where.not(id: liked_ids + disliked_ids)
# 
    # nouvelle ligne
    # where(id: users_in_radius).where.not(user: user).where.not(id: liked_ids + disliked_ids)
  }
end
