class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :comment
      t.integer :parent_id
      t.references :news, null: false, foreign_key: true

      t.timestamps
    end
  end
end
