class Payout < ApplicationRecord
  belongs_to :merchant
	has_many :transactions

  before_validation :merchant_has_unpaid_txns
  before_validation :calculate_payment
  after_commit :update_transactions, on: :create

  monetize :fee_charged, as: :fee_charged_cents
  monetize :amount, as: :amount_cents


  def update_transactions
    unpaid_transactions = merchant.transactions.unpaid
    unpaid_transactions.update_all(payout_id: self.id, state: 'paid')
  end

  def merchant_has_unpaid_txns
    return true if merchant.transactions.unpaid.any?
    self.errors.add(:base, "Merchant has no unpaid transactions")
  end

  def calculate_payment
    total_fee_charged = 0
    total_amount = 0

    merchant.transactions.unpaid.find_each do |txn|
      txn_amount_cents = txn.amount_cents.cents
      processing_fee = processing_fee(txn_amount_cents, txn.payment_source.payment_type)
      total_fee_charged += processing_fee
      total_amount += txn_amount_cents - processing_fee
    end

    self.fee_charged = total_fee_charged
    self.amount = total_amount
  end

  def processing_fee(amount, payment_type)
    if payment_type == 'Bank'
      (amount * (1 * 0.01)).round + 100
    else
      (amount * (2.9 * 0.01)).round + 30
    end
  end
end