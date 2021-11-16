require 'csv'

CSV.foreach(Rails.root.join('db/data/routing_numbers.csv'), headers: false, :quote_char => "|") do |row|
  RoutingNumber.create(number: row[1], bank_name: row[2]) 
end

movies = Merchant.create([{ name: 'Merchant 1' }, { name: 'Merchant 2' }, { name: 'Merchant 3' }])