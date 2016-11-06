class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :event
      t.datetime :date
      t.integer :user_id

      t.timestamps
    end
    add_index :activities, :user_id
  end
end
