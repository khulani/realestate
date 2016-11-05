class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :street
      t.string :city
      t.string :state
      t.decimal :latitude
      t.decimal :longitude
      t.integer :agent
      t.integer :resident
      t.string :status

      t.timestamps
    end
  end
end
