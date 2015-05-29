class AddReservationToItems < ActiveRecord::Migration
  def change
    add_column :items, :reservation, :string
  end
end
