class UserLike < ApplicationRecord
  belongs_to :user
  belongs_to :vinyle

  after_create :verify_match

  def verify_match
    vinyle.user.user_likes.each do |like|
      if user == like.vinyle.user
        unless Match.where(vinyle1: self.vinyle, vinyle2: like.vinyle).exists? || Match.where(vinyle1: like.vinyle, vinyle2: self.vinyle).exists?
          match = Match.create!(vinyle1: self.vinyle, vinyle2: like.vinyle)

          Turbo::StreamsChannel.broadcast_replace_to(
            "user_#{user.id}",
            target: "match_modal",
            partial: "shared/match_modal",
            locals: { match: match }
          )
        end
      end
    end
  end
end
