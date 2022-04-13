class StaticPagesController < ApplicationController
  skip_authorization_check except: :home

  def home
    param = params.dig(:q, :home_team_name_or_guest_team_name_cont)
    @q = SoccerMatch.ransack home_team_name_or_guest_team_name_cont: param
    @pagy, @soccer_matches = pagy @q.result.newest
    authorize! :home, SoccerMatch
  end

  def help; end

  def about; end
end
