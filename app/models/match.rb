class Match < ApplicationRecord
  belongs_to :vinyle1, class_name: "Vinyle", foreign_key: "vinyle1_id"
  belongs_to :vinyle2, class_name: "Vinyle", foreign_key: "vinyle2_id"
  has_many :messages, dependent: :destroy

  validates :vinyle1_id, uniqueness: { scope: :vinyle2_id }
  validates :vinyle2_id, uniqueness: { scope: :vinyle1_id }


end
