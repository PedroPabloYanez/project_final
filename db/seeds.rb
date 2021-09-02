# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all
Team.destroy_all
TeamUser.destroy_all

20.times do
    User.create(
        user_name: Faker::Sports::Football.player, 
        email: Faker::Internet.email,
        user_photo: Faker::Avatar.image
    )
end

15.times do
    Team.create(
        name: Faker::Music::RockBand.name, 
        color: Faker::Color.color_name
    )
end


35.times do 
    TeamUser.create!(
    team_id: Team.pluck("id").sample,
    user_id: User.pluck("id").sample
    )
end
    