module SoccerMatchHelper
  def calculate_score team_id, soccer_match_id
    GoalResult.score(team_id, soccer_match_id).count
  end

  def time_handling match_time
    match_time.strftime(Settings.format_time)
  end

  def check_status_match status
    t "soccer_matches.#{status ? 'finished-status' : 'unfinished-status'}"
  end

  def load_result soccer_match
    result_home = calculate_score(soccer_match.home_team, soccer_match.id)
    result_guest = calculate_score(soccer_match.guest_id, soccer_match.id)
    return "win" if result_home > result_guest
    return "draw" if result_home == result_guest

    "lose"
  end

  def load_result_score soccer_match
    result_home = calculate_score(soccer_match.home_team, soccer_match.id)
    result_guest = calculate_score(soccer_match.guest_id, soccer_match.id)
    return "other" unless Bet.bet_types["h#{result_home}g#{result_guest}"]

    "h#{result_home}g#{result_guest}"
  end
end
