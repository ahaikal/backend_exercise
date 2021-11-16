require 'rails_helper'

RSpec.describe Payout, type: :model do
  describe 'Validations' do
    let(:merchant) { create(:merchant) }
    let(:bank_payment) { build(:payment, payment_type: 'Bank', routing_number: '011001742', amount_cents: 1_0000, merchant_id: merchant.id) }
    let(:card_payment) { build(:payment, payment_type: 'Card', card_number: '4242424242424242', amount_cents: 1_000, merchant_id: merchant.id) }
    before(:each) do
      bank_payment.make_payment
      card_payment.make_payment
    end

    context 'Process Payout' do
      it "merchant has unpaid transactions" do
        expect(merchant.transactions.unpaid.size).to eq(2)
      end

      context 'create payout' do
        let(:payout) { create(:payout, merchant_id: merchant.id) }

        it 'amount' do
          expect(payout.amount).to eq(1086970)
        end

        it 'fee_charged' do
          expect(payout.fee_charged).to eq(13030)
        end

        it 'change state to paid to processed transactions' do
          expect(payout.transactions.paid.size).to eq(2)
        end
      end
    end
  end
end
