class UserLike < ApplicationRecord
  belongs_to :user
  belongs_to :vinyle

  after_commit :verify_match

  # Quand je crée un like :
  # 1. Je regarde le vinyle
  # 2. Je regarde son user
  # 3. Je regarde ses likes
  # 4. Pour chaque like je regarde le vinyle qu'il a liké
  # 5. Je verifie si le vinyle a pour propriétaire le user qui vient de créer un like

  def verify_match
    self.vinyle.user.user_likes.each do |like|
      if self.vinyle.user == like.vinyle.user
        Match.create!(vinyle1: self.vinyle, vinyle2: like.vinyle)
      end
    end
  end

end
