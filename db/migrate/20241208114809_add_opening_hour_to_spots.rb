class AddOpeningHourToSpots < ActiveRecord::Migration[8.0]
  def change
    add_column :spots, :opening_hours, :string
  end
end
