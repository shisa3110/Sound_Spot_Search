class AddUserToSpots < ActiveRecord::Migration[8.0]
  def change
    add_reference :spots, :user, foreign_key: true
  end
end
