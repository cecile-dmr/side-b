class Match < ApplicationRecord
  belongs_to :vinyle1, class_name: "Vinyle"
  belongs_to :vinyle2, class_name: "Vinyle"
  has_many :messages

  validates :vinyle1_id, uniqueness: { scope: [:vinyle1, :vinyle2] }
  validates :vinyle2_id, uniqueness: { scope: [:vinyle1, :vinyle2] }
end
