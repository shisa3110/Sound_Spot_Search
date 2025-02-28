class RenameImageColumnToInstruments < ActiveRecord::Migration[8.0]
  def change
    rename_column :instruments, :image, :instrument_image
  end
end
