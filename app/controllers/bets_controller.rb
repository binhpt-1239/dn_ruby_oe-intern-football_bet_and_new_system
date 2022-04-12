class BetsController < ApplicationController
  authorize_resource
  before_action :logged_in_user, :load_match, only: :index

  def index
    match_bets = @match.bets
    @pagy, @bets = pagy match_bets.newest, items: Settings.digits.digit_6
  end

  private

  def load_match
    @match = SoccerMatch.find_by id: params[:match_id]
    return if @match

    flash[:warning] = t ".not_found_match"
    redirect_to root_path
  end
end
