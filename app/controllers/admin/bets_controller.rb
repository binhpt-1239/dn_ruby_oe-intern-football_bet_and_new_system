class Admin::BetsController < Admin::BaseController
  include EventsHelper

  before_action :load_match, only: %i(create update_bets)
  before_action :check_status_match, only: :update_bets

  def create
    return unless check_bet_empty? @soccer_match

    arr = Settings.arr_content_bets
    begin
      SoccerMatch.transaction do
        arr.each_with_index do |content, i|
          @soccer_match.bets.create!(rate: 1, bet_type: i + 1, content: content)
        end
      end
      flash[:success] = t ".bets_default"
    rescue StandardError
      action_if_create_false
    end
  end

  def update_bets
    if @soccer_match.update bets_params
      flash[:success] = t ".success"
    else
      flash[:warning] = t ".fails"
    end
    redirect_to admin_root_path
  end

  private

  def bets_params
    params.require(:soccer_match)
          .permit(bets_attributes: [:id, :rate, :bet_type, :content])
  end

  def load_match
    @soccer_match = SoccerMatch.find_by id: params[:match_id]
    return if @soccer_match

    flash[:warning] = t ".match_not_found"
    redirect_to admin_root_path
  end

  def check_status_match
    return unless @soccer_match.status

    flash[:warning] = t ".match_finished"
    redirect_to admin_root_path
  end

  def action_if_create_false
    flash[:warning] = t ".fails"
    redirect_to admin_root_path
  end
end
