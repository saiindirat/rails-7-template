class AddOriginAndDestinationToRides < ActiveRecord::Migration[7.1]
  def change
    add_column :rides, :origin, :string
    add_column :rides, :destination, :string
  end
end
