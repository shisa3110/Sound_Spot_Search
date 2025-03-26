class RemoveGenderFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :gender, :integer
  end
end
