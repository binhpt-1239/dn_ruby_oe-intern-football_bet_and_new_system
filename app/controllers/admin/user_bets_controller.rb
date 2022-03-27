class Admin::UserBetsController < Admin::BaseController
  include SoccerMatchHelper

  before_action :load_match, :load_bet, :check_status_match, only: :index

  def index
    user_bets = @bet.user_bets.newest
    @pagy, @user_bets = pagy user_bets, items: Settings.digits.digit_6
  end

  private

  def load_match
    @match = SoccerMatch.find_by id: params[:match_id]
    return if @match

    flash[:warning] = t ".not_found_match"
    redirect_to admin_root_path
  end

  def load_bet
    @bet = if params[:score]
             @match.bets.find_by bet_type: load_result_score(@match)
           else
             @match.bets.find_by bet_type: load_result(@match)
           end
    return if @bet

    flash[:warning] = t ".not_found_bet"
    redirect_to admin_root_path
  end

  def check_status_match
    return if @match.status

    flash[:warning] = t ".match_not_begin"
    redirect_to admin_root_path
  end
end
