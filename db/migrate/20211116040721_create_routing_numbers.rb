class CreateRoutingNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :routing_numbers, id: :uuid do |t|
      t.string :number
      t.string :bank_name
      t.index :number

      t.timestamps
    end
  end
end
