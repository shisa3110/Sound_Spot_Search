class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :instrument, foreign_key: true

      t.timestamps
    end
    add_index :likes, [ :user_id, :instrument_id ], unique: true
  end
end
