class AddStatusToSoccerMatches < ActiveRecord::Migration[6.0]
  def change
    add_column :soccer_matches, :status, :boolean, default: false
  end
end
