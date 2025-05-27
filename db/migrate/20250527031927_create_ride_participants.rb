class CreateRideParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :ride_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ride, null: false, foreign_key: true

      t.timestamps
    end
  end
end
