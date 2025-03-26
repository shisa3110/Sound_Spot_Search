class ChangeNameNullInSpots < ActiveRecord::Migration[8.0]
  def change
    change_column_null :spots, :name, true
  end
end
