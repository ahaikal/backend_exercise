class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions, id: :uuid do |t|
    	t.integer 	 :amount
    	t.datetime 	 :bill_me_on
    	t.string 		 :state, default: 'created'
    	t.references :merchant, type: :uuid
    	t.references :payment_source, type: :uuid
    	t.references :payout, type: :uuid

      t.timestamps
    end
  end
end
