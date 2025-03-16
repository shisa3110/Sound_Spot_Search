class RemoveUniqueConstraintFromUsersName < ActiveRecord::Migration[8.0]
  def change
    remove_index :users, :name, unique: true
    add_index :users, :name
  end
end
