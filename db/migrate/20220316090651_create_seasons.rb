class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :name
      t.integer :begin_year
      t.integer :end_year

    end
  end
end
