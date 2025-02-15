class AddSpotImageToSpot < ActiveRecord::Migration[8.0]
  def change
    add_column :spots, :spot_image, :string
  end
end
