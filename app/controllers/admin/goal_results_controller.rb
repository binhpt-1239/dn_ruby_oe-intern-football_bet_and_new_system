class Admin::GoalResultsController < Admin::BaseController
  skip_before_action :verify_authenticity_token
  before_action :load_match, only: %i(create new)
  before_action :check_team, only: :new
  before_action :check_status_match, only: :create

  def new
    @goals_home_team = @soccer_match.goal_results.score @team_home.id,
                                                        @soccer_match.id
    @goals_guest_team = @soccer_match.goal_results.score @team_guest.id,
                                                         @soccer_match.id
    @soccer_match.goal_results.build
  end

  def create
    if @soccer_match.update goal_result_params
      flash[:success] = t ".create_goal_success"
    else
      flash[:warning] = t ".create_goal_fails"
    end
    redirect_to admin_root_path
  end

  private

  def goal_result_params
    params.require(:soccer_match)
          .permit(:status, goal_results_attributes: [:player_id, :time_goal,
                                                     :team_id])
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

  def check_team
    @team_home = @soccer_match.home_team
    @team_guest = @soccer_match.guest_team
    return if @team_home && @team_guest

    flash[:warning] = t ".team_not_found"
    redirect_to admin_root_path
  end
end
