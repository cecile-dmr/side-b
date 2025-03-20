class Match < ApplicationRecord
  belongs_to :vinyle1, class_name: "Vinyle"
  belongs_to :vinyle2, class_name: "Vinyle"
  has_many :messages, dependent: :destroy

  validates :vinyle1_id, uniqueness: { scope: :vinyle2_id }
end
