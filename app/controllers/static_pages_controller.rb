class StaticPagesController < ApplicationController
  skip_authorization_check except: :home

  def home
    @pagy, @soccer_matches = pagy SoccerMatch.includes(:home_team, :guest_team)
                                             .newest
    authorize! :home, SoccerMatch
  end

  def help; end

  def about; end
end
