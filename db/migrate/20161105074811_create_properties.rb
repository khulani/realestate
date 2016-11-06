class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :agent_id
      t.integer :resident_id
      t.string :status

      t.timestamps
    end
    add_index :properties, :status
    add_index :properties, :agent_id
    add_index :properties, :resident_id
    add_index :properties, [:city, :state]
  end
end
