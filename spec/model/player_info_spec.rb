require "rails_helper"
RSpec.describe PlayerInfo, type: :model do
  describe "Associations" do
    it {should belong_to(:player)}
    it {should belong_to(:team_tournament)}
  end
end
