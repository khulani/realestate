class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :account_type

      t.timestamps
    end
    add_index :user, :username, unique: true
  end
end
