class AddNotesToRides < ActiveRecord::Migration[7.1]
  def change
    add_column :rides, :notes, :text
  end
end
