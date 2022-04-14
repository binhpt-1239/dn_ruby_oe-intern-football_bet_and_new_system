require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  describe "GET home" do
    it "render home" do
      get :home
      expect(response).to render_template(:home)
    end

    context "when search ransack" do
      let!(:team_guest){Team.create!(name: "Brazil")}
      let!(:team_home){Team.create!(name: "VietNam")}
      let!(:match){SoccerMatch.create!(tournament_id: 1, time: Time.now + 1.day,
                                          home_id: team_home.id, guest_id: team_guest.id)}

      it "search team name equal Brazil" do
        get :home, params: {q: {home_team_name_or_guest_team_name_cont: "Brazil"}}
        expect(assigns(:soccer_matches).first.guest_name).to eq(team_guest.name)
      end
      it "search team name equal VietNam" do
        get :home, params: {q: {home_team_name_or_guest_team_name_cont: "VietNam"}}
        expect(assigns(:soccer_matches).first.home_name).to eq(team_home.name)
      end
    end
  end
  describe "GET help" do
    it "render help" do
      get :help
      expect(response).to render_template(:help)
    end
  end
  describe "GET about" do
    it "render about" do
      get :about
      expect(response).to render_template(:about)
    end
  end
end
