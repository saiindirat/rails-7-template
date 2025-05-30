class AddPriceAndImageToRides < ActiveRecord::Migration[7.1]
  def change
    add_column :rides, :price, :decimal
    add_column :rides, :image, :string
  end
end
