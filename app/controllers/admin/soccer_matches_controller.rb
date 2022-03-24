class Admin::SoccerMatchesController < Admin::BaseController
  def index
    @pagy, @soccer_matches = pagy SoccerMatch.includes(:home_team, :guest_team)
                                             .newest
  end
end
