class Vinyle < ApplicationRecord
  belongs_to :user
  has_many :primary_vinyles, class_name: "Vinyle", foreign_key: "vinyle1_id"
  has_many :secondary_vinyles, class_name: "Vinyle", foreign_key: "vinyle2_id"
  has_many :user_likes
  has_many :user_dislikes

  has_one_attached :photo
  # validates :photo, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  validates :quality, :presence => true
  validates :description, presence: { message: "Ne peut pas être vide" }
  validates :title, presence: { message: "Ne peut être vide"}
  validates :artist, presence: { message: "Ne peut être vide"}
  validates :year, presence: { message: "Ne peut être vide"}
  # TODO : Available

  scope :not_liked_or_disliked_by, ->(user) {
    # retourne un array avec tous les users dans le périmètre
    users_in_radius = User.near([user.latitude, user.longitude], user.search_radius)

    users_id_in_radius = []

    users_in_radius.each do |i|
      users_id_in_radius << i.id
    end

    # retourne tous les vinyles des users qui sont dans le périmètres
    # vinyles_in_radius = Vinyle.where(user_id: users_id_in_radius)

    current_user_vinyles_ids = Vinyle.where(user_id: user).pluck(:id)
    liked_ids = UserLike.where(user: user).pluck(:vinyle_id)
    disliked_ids = UserDislike.where(user: user).pluck(:vinyle_id)
    where(user_id: users_id_in_radius).where.not(id: liked_ids + disliked_ids + current_user_vinyles_ids)
    # where.not(user: user).where.not(id: liked_ids + disliked_ids)

    # nouvelle ligne
    # where(id: users_in_radius).where.not(user: user).where.not(id: liked_ids + disliked_ids)
  }
end
