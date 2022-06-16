class CreateMoneyTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :money_transfers do |t|
      t.references :sender, null: false, foreign_key: true
      t.references :receiver, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.timestamps
    end
  end
end
