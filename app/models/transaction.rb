class Transaction < ApplicationRecord
  scope :unpaid, -> { where(state: 'created') }
  scope :paid, -> { where(state: 'paid') }

	belongs_to :merchant
	belongs_to :payment_source, optional: true
	belongs_to :payout, optional: true

  monetize :amount, as: :amount_cents
end