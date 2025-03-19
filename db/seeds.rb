# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "discogs"

Message.destroy_all
UserLike.destroy_all
puts "Cleaning user likes..."
UserDislike.destroy_all
puts "Cleaning user dislikes..."
Match.destroy_all
puts "Cleaning matches..."
Vinyle.all{ |vinyle| vinyle.photo.purge }
Vinyle.destroy_all
puts "Cleaning vinyles..."
User.destroy_all
puts "Cleaning users..."

wrapper = Discogs::Wrapper.new("Side-b", user_token: ENV["DISCOGS"])

quality = ["Parfait", "Très bon", "Bon"]



theo = User.create!(email: "theo@mail.com", password: "hellohello", address: "Lille")
p theo
cecile = User.create!(email: "cecile@mail.com", password: "hellohello", address: "Santes")
p cecile
baptiste = User.create!(email: "baptiste@mail.com", password: "hellohello", address: "Marcq-en-Baroeul")
p baptiste
aldjia = User.create!(email: "aldjia@mail.com", password: "hellohello", address: "Villeneuve-d'Ascq")
p aldjia
total = User.create!(email: "total@mail.com", password: "hellohello", address: "Lille")
p total
users = [theo, cecile, baptiste, aldjia]

puts ENV["DISCOGS"]
users.each do |user|

  # Vinyle.create(
  #   title: "#{user.email} vinyle",
  #   artist: 'artiste',
  #   description: "description",
  #   available: true,
  #   quality: "super",
  #   year: "2004",
  #   user: user
  # )

  puts "Création d'un vinyle"
  def release_as_photo?(release)
    release.images.nil? ? nil : release.images[0]
  end

  10.times do

    release = nil
    while release == nil
      tmp_release = wrapper.get_release("#{rand(250000..300000)}")
      release = tmp_release if release_as_photo?(tmp_release)
    end

    vinyle = Vinyle.new(
    title: release.title,
    artist: release.artists_sort,
    description: release.genres&.first || release.genres || release.genre || "Unknown",
    available: true,
    quality: quality.sample,
    year: release&.year || "2004",
    user: user)

    photo = URI.parse(release.images[0].uri).open
    vinyle.photo.attach(io: photo, filename: "#{vinyle.title}.jpeg", content_type: 'image/jpeg')
    puts vinyle.valid?
    if vinyle.valid?
      vinyle.save!
      puts "Created #{vinyle.title}"
    else
      puts "vinyle incomplet"
    end
  end

  # Vinyle.create(
  #   title: "#{user.email} vinyle 2",
  #   artist: 'artiste',
  #   description: "description",
  #   available: true,
  #   quality: "super",
  #   year: "2004",
  #   user: user
  # )

end

#------------------------------------------------------------------

# users = User.all
# vinyles = Vinyle.all

# User.all.each do |user|
#   vinyles = Vinyle.where.not(user: user)
#   UserLike.create!(user: user, vinyle: vinyles.sample)
# end

puts "Création des likes..."






UserLike.create!(user: theo, vinyle: aldjia.vinyles.first)
# UserLike.create!(user: aldjia, vinyle: theo.vinyles.first)

# UserLike.create!(user: theo, vinyle: aldjia.vinyles.last)
# UserLike.create!(user: aldjia, vinyle: theo.vinyles.last)



UserLike.create!(user: cecile, vinyle: aldjia.vinyles.first)
# UserLike.create!(user: aldjia, vinyle: cecile.vinyles.first)

# UserLike.create!(user: cecile, vinyle: aldjia.vinyles.last)
# UserLike.create!(user: aldjia, vinyle: cecile.vinyles.last)

UserLike.create!(user: baptiste, vinyle: aldjia.vinyles.first)
# UserLike.create!(user: aldjia, vinyle: baptiste.vinyles.first)

UserLike.create!(user: baptiste, vinyle: aldjia.vinyles.last)
# UserLike.create!(user: aldjia, vinyle: baptiste.vinyles.last)

# puts UserLike.count
# puts Match.count
