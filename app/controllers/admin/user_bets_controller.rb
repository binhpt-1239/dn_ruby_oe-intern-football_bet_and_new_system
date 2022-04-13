class Admin::UserBetsController < Admin::BaseController
  include SoccerMatchHelper
  authorize_resource

  before_action :load_match, :load_bet, :check_status_match, only: :index

  def index
    @q = UserBet.ransack amount_gteq: params.dig(:q, :amount_gteq)
    user_bets = @q.result.accessible_by(current_ability)
    @pagy, @user_bets = pagy user_bets, items: Settings.digits.digit_6
  end

  private

  def load_match
    param = params[:match_id] || params.dig(:q, :match_id)
    @match = SoccerMatch.find_by id: param
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
