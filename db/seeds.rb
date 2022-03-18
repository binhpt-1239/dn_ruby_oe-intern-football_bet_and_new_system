User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "123456",
             password_confirmation: "123456",
             admin: true)

15.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

50.times do |n|
  name = Faker::Sports::Football.player
  position = Faker::Sports::Football.position
  number = rand(1..35)
  Player.create!(name: name,
                 position: position,
                 number: number)
end

5.times do |n|
  name = Faker::Sports::Football.team
  Team.create!(name: name)
end

Season.create!(name: "2021 - 2022",
               begin_year: 2021,
               end_year: 2022)

Tournament.create!(name: "BK-TB",
                   begin_time: "2021-06-15 00:30:00",
                   end_time: "2022-06-15 00:30:00")

SeasonTournament.create!(season_id: 1,
                         tournament_id: 1)

5.times do |n|
  TeamSeasonTournament.create!(team_id: n+1,
                     season_tournament_id: 1)
end

currency_type = ["win", "lose", "recharge", "withdraw", "transfer"]
5.times do |n|
  CurrencyType.create!(name: currency_type[n])
end

random_id = (1..50).to_a.shuffle
50.times do |n|
  player_id = random_id[n]
  team_id = n / 10
  team_id = 5 if team_id == 0
  PlayerInfo.create!(player_id: player_id,
                     team_id: team_id,
                     season_tournament_id: 1
  )
end
