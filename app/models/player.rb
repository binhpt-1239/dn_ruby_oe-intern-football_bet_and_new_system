class Player < ApplicationRecord
  has_many :goal_results, dependent: :destroy
  has_many :player_infos, dependent: :destroy
end
