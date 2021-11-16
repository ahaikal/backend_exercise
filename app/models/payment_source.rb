class PaymentSource < ApplicationRecord
	has_many :transactions

  # ATTR_ENCRYPTED_KEY should be an environment variable
  # We should also filter these params from the logs
  ATTR_ENCRYPTED_KEY = "nFSeSCCzsw0gALaKZCw9GayqzdPBnD1C"

  attr_encrypted :card_number, key: ATTR_ENCRYPTED_KEY
  attr_encrypted :exp_month, key: ATTR_ENCRYPTED_KEY
  attr_encrypted :exp_year, key: ATTR_ENCRYPTED_KEY
  attr_encrypted :cvc, key: ATTR_ENCRYPTED_KEY
  attr_encrypted :billing_zip, key: ATTR_ENCRYPTED_KEY
  attr_encrypted :account_number, key: ATTR_ENCRYPTED_KEY
  attr_encrypted :routing_number, key: ATTR_ENCRYPTED_KEY
end
