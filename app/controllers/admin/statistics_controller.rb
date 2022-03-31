class Admin::StatisticsController < Admin::BaseController
  include EventsHelper

  before_action :check_year, only: :index

  def index
    @start = fix_date(params[:start_month])
    @end = fix_date(params[:end_month])
    @user_bets = UserBet.search @start.beginning_of_month, @end.end_of_month
    load_total @user_bets
  end

  private

  def fix_date param_date
    if param_date.present?
      Date.new(@year,
               param_date["date(2i)"].to_i,
               param_date["date(3i)"].to_i)
    else
      Time.zone.today
    end
  end

  def check_year
    @year = if params[:years]
              params[:years]["date(1i)"].to_i
            else
              Time.zone.now.year
            end
  end

  def load_total user_bets
    winners = user_bets.load_result_bet true
    @total_winner = total_win_bet winners
    @total_winner_has_rate = @total_winner - user_bets.load_result_bet(true)
                                                      .sum(:amount)
    @total_loser = user_bets.load_result_bet(false).sum(:amount)
    @total = user_bets.sum(:amount)
  end
end
