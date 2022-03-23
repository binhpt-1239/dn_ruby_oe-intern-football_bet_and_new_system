class StaticPagesController < ApplicationController
  def home
    @pagy, @soccer_matches = pagy SoccerMatch.includes(:home_team, :guest_team)
                                             .newest
  end

  def help; end

  def about; end
end
