class CreatePaymentSources < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_sources, id: :uuid do |t|
    	t.string :payment_type
    	t.string :encrypted_card_number
      t.string :encrypted_card_number_iv
    	t.string :encrypted_exp_month
      t.string :encrypted_exp_month_iv
    	t.string :encrypted_exp_year
      t.string :encrypted_exp_year_iv
    	t.string :encrypted_cvc
      t.string :encrypted_cvc_iv
    	t.string :encrypted_billing_zip
      t.string :encrypted_billing_zip_iv
    	t.string :encrypted_account_number
      t.string :encrypted_account_number_iv
    	t.string :encrypted_routing_number
      t.string :encrypted_routing_number_iv
    	t.string :state

      t.timestamps
    end
  end
end
