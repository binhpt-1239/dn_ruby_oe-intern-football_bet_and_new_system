class CreateNewses < ActiveRecord::Migration[6.0]
  def change
    create_table :newses do |t|

      t.timestamps
    end
  end
end
