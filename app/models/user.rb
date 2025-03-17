class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :vinyles, dependent: :destroy
  has_many :user_likes
  has_many :user_dislikes
  has_many :matches, through: :vinyles

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  after_initialize do
    self.search_radius ||= 50
  end

end
