class CreateSpots < ActiveRecord::Migration[8.0]
  def change
    create_table :spots do |t|
      t.string :name, null: false
      t.integer :category
      t.string :post_code
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :phone_number
      t.string :web_site
      t.integer :room_charge
      t.timestamps
    end
  end
end
