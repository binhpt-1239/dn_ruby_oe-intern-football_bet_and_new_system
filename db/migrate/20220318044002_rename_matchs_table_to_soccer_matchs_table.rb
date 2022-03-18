class RenameMatchsTableToSoccerMatchsTable < ActiveRecord::Migration[6.0]
  def change
    rename_table :matches, :soccer_matches
  end
end
