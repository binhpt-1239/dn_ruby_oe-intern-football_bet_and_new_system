require "rails_helper"
RSpec.describe GoalResult, type: :model do
  describe "Associations" do
    it {should belong_to :player}
    it {should belong_to :soccer_match}
    it {should belong_to :team}
  end

  describe "scope" do
    let!(:time_goal){30}
    let!(:home_team){FactoryBot.create :home_team}
    let!(:guest_team){FactoryBot.create :guest_team}
    let!(:player){FactoryBot.create :player}
    let!(:soccer_match){SoccerMatch.create(tournament_id: 1, time: Time.now + 1.day,
                                          home_id: home_team.id, guest_id: guest_team.id)}
    let!(:team_tournament){TeamTournament.create(team_id: home_team.id, tournament_id: 1)}
    let!(:player_infor){PlayerInfo.create(player_id: player.id, team_tournament_id: team_tournament.id)}
    let!(:goal_result){GoalResult.create(player_id: player.id, time_goal: time_goal,
                                        soccer_match_id: soccer_match.id, team_id: home_team.id)}

    it "check score home team equal 1" do
      expect(GoalResult.score(home_team.id, soccer_match.id).count).to be(1)
    end
    it "check score guest team nil" do
      expect(GoalResult.score(guest_team.id, soccer_match.id).count).to be(0)
    end
    it "check time goal" do
      expect(GoalResult.load_time_goal(soccer_match.id).first.time_goal).to eq(time_goal)
    end
  end

  describe "delegate" do
    it {should delegate_method(:name).to(:player).with_prefix(:player).allow_nil}
  end
end
