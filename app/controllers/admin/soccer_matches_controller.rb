class Admin::SoccerMatchesController < Admin::BaseController
  before_action :load_soccer_match, only: %i(edit update)
  before_action :load_teams_and_tournament, only: %i(new edit)

  def index
    @pagy, @soccer_matches = pagy SoccerMatch.includes(:home_team, :guest_team)
                                             .newest
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

  def load_teams_and_tournament
    @teams = Team.all
    @tournaments = Tournament.all
  end
end
