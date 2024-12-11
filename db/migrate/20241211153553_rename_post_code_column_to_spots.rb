class RenamePostCodeColumnToSpots < ActiveRecord::Migration[8.0]
  def change
    rename_column :spots, :post_code, :postal_code
  end
end
