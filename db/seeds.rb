# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "discogs"
wrapper = Discogs::Wrapper.new("Side-b", user_token: ENV["DISCOGS"])

quality = ["Parfait", "Très bon", "Bon"]

Vinyle.destroy_all
puts "Cleaning vinyles..."
User.destroy_all
puts "Cleaning users..."

theo = User.create!(email: "theo@mail.com", password: "hellohello")
p theo
cecile = User.create!(email: "cecile@mail.com", password: "hellohello")
p cecile
baptiste = User.create!(email: "baptiste@mail.com", password: "hellohello")
p baptiste
aldjia = User.create!(email: "aldjia@mail.com", password: "hellohello")
p aldjia
users = [theo, cecile, baptiste, aldjia]

puts ENV["DISCOGS"]
20.times do
  puts "Création d un vinyle"
  release = wrapper.get_release("#{rand(250000..300000)}")
  vinyle = Vinyle.new(
    title: release.title,
    artist: release.artists_sort,
    description: release.genres&.first || release.genres || release.genre || "Unknown",
    available: true,
    quality: quality.sample,
    year: release&.year || "2004",
    user: users.sample
  )
  puts vinyle.inspect
  if vinyle.save!
    puts "Created #{vinyle.title}"
  else
    puts "vinyle incomplet"
  end
end
