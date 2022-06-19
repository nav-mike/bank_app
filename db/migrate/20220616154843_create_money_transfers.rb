class CreateMoneyTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :money_transfers do |t|
      t.integer :sender_id, null: false, index: true
      t.integer :receiver_id, null: false, index: true
      t.decimal :amount, null: false
      t.timestamps
    end
  end
end
