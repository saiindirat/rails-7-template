# == Schema Information
#
# Table name: ride_participants
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ride_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_ride_participants_on_ride_id  (ride_id)
#  index_ride_participants_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (ride_id => rides.id)
#  fk_rails_...  (user_id => users.id)
#
class RideParticipant < ApplicationRecord
  belongs_to :ride
  belongs_to :user

  # Only validation needed is checking remaining seats based on current passengers
  validate :ride_has_room, on: :create

  private

  def ride_has_room
    if ride.passengers.count >= ride.available_seats
      errors.add(:ride, "is full.")
    end
  end
end
