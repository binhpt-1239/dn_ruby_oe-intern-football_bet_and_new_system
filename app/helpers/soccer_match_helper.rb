module SoccerMatchHelper
  def calculate_score team_id, soccer_match_id
    GoalResult.score(team_id, soccer_match_id).count
  end

  def time_handling match_time
    match_time.strftime(Settings.format_time)
  end

  def check_status_match status
    t "soccer_matches.soccer_match.#{status ? 'finished-status' : 'unfinished'}"
  end
end
