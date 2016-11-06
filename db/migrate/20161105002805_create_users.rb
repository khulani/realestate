class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :account_type
      t.string :token

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :account_type
    add_index :users, :token
  end
end
