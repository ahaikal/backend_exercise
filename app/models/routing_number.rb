class RoutingNumber < ApplicationRecord
  validates :number, presence: true, uniqueness: true
end
