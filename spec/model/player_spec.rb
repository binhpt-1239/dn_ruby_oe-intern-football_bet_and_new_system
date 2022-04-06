require "rails_helper"
RSpec.describe Player, type: :model do
  describe "Associations" do
    it {should have_many(:goal_results).dependent(:destroy)}
    it {should have_many(:player_infos).dependent(:destroy)}
  end
end
