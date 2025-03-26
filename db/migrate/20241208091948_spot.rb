class Spot < ActiveRecord::Migration[8.0]
  def change
    add_column :spots, :place_id, :string
  end
end
