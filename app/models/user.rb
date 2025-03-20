class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true

  has_many :vinyles, dependent: :destroy
  has_many :user_likes
  has_many :user_dislikes
  has_many :matches, through: :vinyles

  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  before_create :set_radius

  private

  def set_radius
    self.search_radius = 50
  end
end
