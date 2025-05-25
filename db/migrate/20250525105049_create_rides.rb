class CreateRides < ActiveRecord::Migration[7.1]
  def change
    create_table :rides do |t|
      t.integer :user_id
      t.string :location
      t.datetime :departure_time
      t.string :map_url
      t.integer :available_seats

      t.timestamps
    end
  end
end
