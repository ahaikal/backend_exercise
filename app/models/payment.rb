class Payment
	include ActiveModel::Model

  attr_accessor(
    :payment_type,
    :card_number,
    :exp_month,
    :exp_year,
    :cvc,
    :billing_zip,
    :account_number,
    :routing_number,
    :amount_cents,
    :bill_me_on,
    :merchant_id
  )

  validates :payment_type, presence: true
  validates :amount_cents, presence: true
  validates :merchant_id, presence: true

  validates :card_number, presence: true, if: :is_card_type?
  validates :exp_month, :format => { :with => /[0-9]/, :message => "Not a valid digit number" }, presence: true, if: :is_card_type?
  validates :exp_year, :format => { :with => /[0-9]/, :message => "Not a valid digit number" }, presence: true, if: :is_card_type?
  validates :cvc, :format => { :with => /[0-9]/, :message => "Not a valid digit number" }, presence: true, if: :is_card_type?
  validates :billing_zip, :format => { :with => /[0-9]/, :message => "Not a valid digit number" }, presence: true, if: :is_card_type?
  validate  :card_number_value, if: :is_card_type?

  validates :account_number, :format => { :with => /[0-9]/, :message => "Not a valid digit number" }, presence: true, if: :is_bank_account_type?
  validates :routing_number, presence: true, if: :is_bank_account_type?
  validate  :routing_number_value, if: :is_bank_account_type?

  def make_payment
    if valid?
      ActiveRecord::Base.transaction do
        payment_source = PaymentSource.create!(payment_type: payment_type, card_number: card_number, exp_month: exp_month,
                                              exp_year: exp_year, cvc: cvc, billing_zip: billing_zip,
                                              account_number: account_number, routing_number: routing_number,
                                              state: 'create')
        Transaction.create!(amount_cents: amount_cents, bill_me_on: bill_me_on, payment_source_id: payment_source.id, merchant_id: merchant_id)
      end
    else
    	false
    end
  end

  private

  def card_number_value
    if card_number.match('^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$')
      return true
    else
      self.errors.add(:card_number, "Invalid card_number")
    end
  end

  def routing_number_value
    return true if RoutingNumber.find_by(number: routing_number)
    self.errors.add(:routing_number, "Invalid routing_number")
  end

  def is_card_type?
    payment_type == 'Card'
  end

  def is_bank_account_type?
    payment_type == 'Bank'
  end
end