class RemoveRoomChargeFromSpots < ActiveRecord::Migration[8.0]
  def change
    remove_column :spots, :room_charge
  end
end
