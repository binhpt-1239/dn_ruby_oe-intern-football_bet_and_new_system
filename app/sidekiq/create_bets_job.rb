class CreateBetsJob
  include Sidekiq::Job
  queue_as :default

  def perform match_id
    soccer_match = SoccerMatch.find_by id: match_id
    arr = Settings.arr_content_bets
    SoccerMatch.transaction do
      arr.each_with_index do |content, i|
        soccer_match.bets.create!(rate: 1, bet_type: i + 1, content: content)
      end
    end
  end
end
