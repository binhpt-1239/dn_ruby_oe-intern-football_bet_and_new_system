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

football_team = ["Arsenal", "Barca", "Juventus", "Manchester United", "Real Madrid"]
5.times do |n|
  name = football_team[n]
  Team.create!(name: name)
end

Tournament.create!(name: "BK - TB",
                   begin_time: "2021-06-15",
                   end_time: "2022-06-15")

5.times do |n|
  TeamTournament.create!(team_id: n+1,
                     tournament_id: 1)
end

4.times do |n|
  SoccerMatch.create!(tournament_id: 1, time: Time.now + (n+1).day,
                      home_id: 1, guest_id: n+2)
end

4.times do |n|
  Bet.create!(soccer_match_id: n+1, rate: 1, bet_type: 1, content: "Team Home Win")
  Bet.create!(soccer_match_id: n+1, rate: 1.5, bet_type: 2, content: "Tow Team Draw")
  Bet.create!(soccer_match_id: n+1, rate: 1.8, bet_type: 3, content: "Team Guest Win")
  Bet.create!(soccer_match_id: n+1, rate: 4, bet_type: 4, content: "Score: 0-0")
  Bet.create!(soccer_match_id: n+1, rate: 5, bet_type: 5, content: "Score: 0-1")
  Bet.create!(soccer_match_id: n+1, rate: 3, bet_type: 6, content: "Score: 1-0")
  Bet.create!(soccer_match_id: n+1, rate: 8, bet_type: 7, content: "Score: 1-1")
  Bet.create!(soccer_match_id: n+1, rate: 8, bet_type: 8, content: "Score other")
end

currency_type = ["recharge", "withdraw", "win", "lose", "transfer"]
5.times do |n|
CurrencyType.create!(name: currency_type[n])
end

10.times do |n|
Currency.create!(amount: 300, user_id: n+1, currency_type_id: 1)
Currency.create!(amount: 50, user_id: n+1, currency_type_id: 2)
Currency.create!(amount: 50, user_id: n+1, currency_type_id: 3)
Currency.create!(amount: 45, user_id: n+1, currency_type_id: 4)
end

8.times do |n|
  UserBet.create!(amount: 50, user_id: n+1, bet_id: 1)
  UserBet.create!(amount: 50, user_id: n+1, bet_id: 6)
  UserBet.create!(amount: 10, user_id: n+1, bet_id: n+1)
end

random_id = (1..50).to_a.shuffle
50.times do |n|
  player_id = random_id[n]
  team_id = n / 10
  team_id = 5 if team_id == 0
  PlayerInfo.create!(player_id: player_id,
                     team_tournament_id: team_id
  )
end

player = Team.first.team_tournaments.first.players.first
GoalResult.create!(player_id: player.id, time_goal: Time.now, soccer_match_id: 1, team_id: 1)
SoccerMatch.first.update_columns status: true
