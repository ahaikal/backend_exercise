class CreatePayouts < ActiveRecord::Migration[6.0]
  def change
    create_table :payouts, id: :uuid do |t|
    	t.integer 	 :amount
    	t.integer 	 :fee_charged
    	t.string 		 :state
    	t.references :merchant, type: :uuid

      t.timestamps
    end
  end
end
