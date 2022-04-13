class BetsController < ApplicationController
  authorize_resource
  before_action :logged_in_user, :load_match, only: :index

  def index
    @q = Bet.ransack content_cont: params.dig(:q, :content_cont)
    match_bets = @q.result
    @pagy, @bets = pagy match_bets.newest, items: Settings.digits.digit_6
  end

  private

  def load_match
    param = params[:match_id] || params.dig(:q, :match_id)
    @match = SoccerMatch.find_by id: param
    return if @match

    flash[:warning] = t ".not_found_match"
    redirect_to root_path
  end
end
