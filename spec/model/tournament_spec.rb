require "rails_helper"
RSpec.describe Tournament, type: :model do
  describe "Associations" do
    it {should have_many(:team_tournaments).dependent :nullify}
    it {should have_many(:teams).through :team_tournaments}
    it {should have_many(:soccer_matches).dependent :destroy}
  end
end
