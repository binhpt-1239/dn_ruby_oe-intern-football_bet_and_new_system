class Admin::SoccerMatchesController < Admin::BaseController
  include EventsHelper

  before_action :load_soccer_match, only: %i(edit update show)
  before_action :load_teams_and_tournaments, only: %i(new edit)

  def index
    @pagy, @soccer_matches = pagy SoccerMatch.includes(:home_team, :guest_team)
                                             .newest
    @win = Currency.search_by_type(:win).sum(:amount)
    @lose = Currency.search_by_type(:lose).sum(:amount)
  end

  def create
    @soccer_match = SoccerMatch.new match_params
    if @soccer_match.save
      flash[:info] = t ".successful_create"
      redirect_to new_admin_soccer_match_path
    else
      flash[:danger] = t ".failure_create"
      render :new
    end
  end

  def new
    @soccer_match = SoccerMatch.new
  end

  def edit; end

  def update
    if @soccer_match.update match_params
      flash[:success] = t ".successful_update"
      redirect_to admin_root_path
    else
      flash.now[:danger] = t ".failure_update"
      render :edit
    end
  end

  def show
    winners = @soccer_match.user_bets.load_result_bet true
    total_user_win = @soccer_match.user_bets.load_result_bet(true).sum(:amount)
    @total_win_amount = total_win_bet winners
    @total_amount = @soccer_match.user_bets.sum(:amount)
    @total_winner_has_rate = @total_win_amount - total_user_win
    @total_lose_amount = @soccer_match.user_bets.load_result_bet(false)
                                      .sum(:amount)
  end

  private

  def load_soccer_match
    @soccer_match = SoccerMatch.find_by(id: params[:id])
    return if @soccer_match

    flash[:danger] = t ".not_found_match"
    redirect_to admin_root_path
  end

  def match_params
    params.require(:soccer_match).permit(:home_id, :guest_id,
                                         :time, :tournament_id)
  end

  def load_teams_and_tournaments
    @teams = Team.all
    @tournaments = Tournament.all
  end
end
