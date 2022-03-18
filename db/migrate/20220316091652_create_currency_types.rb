class CreateCurrencyTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :currency_types do |t|
      t.string :name

    end
  end
end
