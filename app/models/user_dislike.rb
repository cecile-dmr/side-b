class UserDislike < ApplicationRecord
  belongs_to :user
  belongs_to :vinyle

  # after_commit :verify_match
end
