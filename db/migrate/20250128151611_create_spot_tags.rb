class CreateSpotTags < ActiveRecord::Migration[8.0]
  def change
    create_table :spot_tags do |t|
      t.references :spot, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  add_index :spot_tags, [:spot_id, :tag_id], unique: true
  end
end
