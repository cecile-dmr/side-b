class Match < ApplicationRecord
  belongs_to :user
  belongs_to :vinyle
  has_many :messages
end
