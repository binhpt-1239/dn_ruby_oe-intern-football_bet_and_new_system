class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :begin_time
      t.date :end_time

      t.timestamps
    end
  end
end
