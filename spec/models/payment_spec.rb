require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'Validations' do
    context 'Presence' do
      it { should validate_presence_of(:payment_type) }
      it { should validate_presence_of(:amount_cents) }
      it { should validate_presence_of(:merchant_id) }
      it { should validate_presence_of(:payment_type) }
    end

    context 'Format' do
      let(:payment) { build(:payment) }

      it "exp_month with valid format" do
        expect(payment.exp_month).to match(/[0-9]/)
      end

      it "exp_year with valid format" do
        expect(payment.exp_year).to match(/[0-9]/)
      end

      it "cvc with valid format" do
        expect(payment.cvc).to match(/[0-9]/)
      end

      it "billing_zip with valid format" do
        expect(payment.billing_zip).to match(/[0-9]/)
      end

      it "account_number with valid format" do
        expect(payment.account_number).to match(/[0-9]/)
      end
    end
  end

  describe 'Bank Payment' do
    context 'Validations' do
      let(:subject) { build(:payment, payment_type: 'Bank', routing_number: '122323') }

      it { should validate_presence_of(:account_number) }
      it { should validate_presence_of(:routing_number) }

      it { should_not validate_presence_of(:card_number) }
      it { should_not validate_presence_of(:exp_month) }
      it { should_not validate_presence_of(:exp_year) }
      it { should_not validate_presence_of(:cvc) }
      it { should_not validate_presence_of(:billing_zip) }

      it 'validates routing_number_value' do
        expect(subject.make_payment ).to be_falsy
      end
    end

    context 'Make Payment' do
      let(:merchant) { create(:merchant) }
      let(:subject) { build(:payment, payment_type: 'Bank', routing_number: '011001742', amount_cents: 1_000, merchant_id: merchant.id) }

      it 'create PaymentSource' do
        expect{ subject.make_payment }.to change(PaymentSource, :count).by(1)
      end

      it 'create Transaction' do
        expect{ subject.make_payment }.to change(Transaction, :count).by(1)
      end
    end
  end

  describe 'Card Payment' do
    context 'Validations' do
      let(:subject) { build(:payment, payment_type: 'Card', card_number: '8888888888888888') }

      it { should_not validate_presence_of(:account_number) }
      it { should_not validate_presence_of(:routing_number) }

      it { should validate_presence_of(:exp_month) }
      it { should validate_presence_of(:exp_year) }
      it { should validate_presence_of(:cvc) }
      it { should validate_presence_of(:billing_zip) }

      it 'validates card_number_value' do
        expect(subject.make_payment ).to be_falsy
      end
    end

    context 'Make Payment' do
      let(:merchant) { create(:merchant) }
      let(:subject) { build(:payment, payment_type: 'Card', card_number: '4242424242424242', amount_cents: 1_000, merchant_id: merchant.id) }

      it 'create PaymentSource' do
        expect{ subject.make_payment }.to change(PaymentSource, :count).by(1)
      end

      it 'create Transaction' do
        expect{ subject.make_payment }.to change(Transaction, :count).by(1)
      end
    end
  end
end
