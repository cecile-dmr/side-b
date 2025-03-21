class Match < ApplicationRecord
  belongs_to :vinyle1, class_name: "Vinyle", foreign_key: "vinyle1_id"
  belongs_to :vinyle2, class_name: "Vinyle", foreign_key: "vinyle2_id"
  has_many :messages, dependent: :destroy

  validates :vinyle1_id, uniqueness: { scope: :vinyle2_id }
  validates :vinyle2_id, uniqueness: { scope: :vinyle1_id }

  scope :pair, lambda { |vinyle1, vinyle2|
    # regarder dans tous les matchs si il y a deja un match
    # entre les deux vinyles
    # Find matches where either:
    # 1. vinyle1 belongs to user1 and vinyle2 belongs to user2
    # 2. vinyle1 belongs to user2 and vinyle2 belongs to user1
    user1_vinyles = vinyle1.user.vinyles.pluck(:id)
    user2_vinyles = vinyle2.user.vinyles.pluck(:id)
    where("(vinyle1_id IN (?) AND vinyle2_id IN (?))", user1_vinyles, user2_vinyles)
  }
end
