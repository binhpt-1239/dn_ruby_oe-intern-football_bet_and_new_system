class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.float :amount
      t.references :user, null: false, foreign_key: true
      t.references :currency_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
