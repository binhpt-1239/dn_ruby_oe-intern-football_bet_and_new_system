module SoccerMatchHelper
  def calculate_score team_id, soccer_match_id
    GoalResult.score(team_id, soccer_match_id).count
  end

  def time_handling match_time
    match_time.strftime(Settings.format_time)
  end

  def check_status_match status
    if status
      t ".finished-status"
    else
      t ".unfinished-status"
    end
  end
end
