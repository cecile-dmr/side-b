class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :vinyles, dependent: :destroy
  has_many :user_likes
  has_many :user_dislikes
  has_many :matches, through: :vinyles
end
