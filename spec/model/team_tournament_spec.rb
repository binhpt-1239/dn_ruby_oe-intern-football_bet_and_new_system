require "rails_helper"
RSpec.describe TeamTournament, type: :model do
  describe "Associations" do
    it {should belong_to :team}
    it {should belong_to :tournament}
    it {should have_many(:player_infos).dependent :destroy}
    it {should have_many(:players).through :player_infos}
  end
end
