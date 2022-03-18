class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :news, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
