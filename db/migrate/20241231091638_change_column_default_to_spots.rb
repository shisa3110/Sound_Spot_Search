class ChangeColumnDefaultToSpots < ActiveRecord::Migration[8.0]
  def change
    change_column_default :spots, :category, from: nil, to: "0"
  end
end
