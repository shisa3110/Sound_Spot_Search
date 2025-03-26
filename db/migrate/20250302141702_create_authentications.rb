class CreateAuthentications < ActiveRecord::Migration[8.0]
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
