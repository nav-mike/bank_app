class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.index :email, unique: true

      t.string :crypted_password, null: false
      t.string :password_salt, null: false

      t.timestamps
    end
  end
end
