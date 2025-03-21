class UserLike < ApplicationRecord
  belongs_to :user
  belongs_to :vinyle

  after_create :verify_match

  def verify_match
    vinyle.user.user_likes.each do |like|
      next unless user == like.vinyle.user
      next if Match.pair(vinyle, like.vinyle).any?

      match = Match.create!(vinyle1: vinyle, vinyle2: like.vinyle)
      broadcast_match(user, match)
    end
  end

  private

  def broadcast_match(user, match)
    Turbo::StreamsChannel.broadcast_replace_to(
      "user_#{user.id}",
      target: "match_modal",
      partial: "shared/match_modal",
      locals: { match: match }
    )
  end
end
