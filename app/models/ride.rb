# == Schema Information
#
# Table name: rides
#
#  id              :bigint           not null, primary key
#  available_seats :integer
#  departure_time  :datetime
#  destination     :string
#  image           :string
#  location        :string
#  map_url         :string
#  notes           :text
#  origin          :string
#  price           :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#

class Ride < ApplicationRecord
  belongs_to :user

  has_many :ride_participants, dependent: :destroy
  has_many :passengers, through: :ride_participants, source: :user

  has_one_attached :image # ActiveStorage

  # VALIDATIONS
  validates :origin, :destination, :departure_time, :available_seats, presence: true
  validates :available_seats, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # METHODS

  # Number of users who have joined the ride
  def spots_taken
    passengers.count
  end

  # Remaining seats (does NOT change the original total)
  def seats_remaining
    return 0 if available_seats.nil?
    [available_seats - spots_taken, 0].max
  end
end
