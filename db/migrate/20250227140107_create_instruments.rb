class CreateInstruments < ActiveRecord::Migration[8.0]
  def change
    create_table :instruments do |t|
      t.string :title, null: false
      t.text :comment, null: false
      t.string :image
      t.integer :kind, default: 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
