# == Schema Information
#
# Table name: rides
#
#  id              :bigint           not null, primary key
#  available_seats :integer
#  departure_time  :datetime
#  location        :string
#  map_url         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
class Ride < ApplicationRecord
  belongs_to :user

  validates :location, presence: true
  validates :departure_time, presence: true
  validates :available_seats, numericality: { only_integer: true, greater_than: 0 }
end
