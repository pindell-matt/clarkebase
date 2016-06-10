require 'pkey_service'
require 'keycleaner_service'

class Wallet < ActiveRecord::Base
  belongs_to  :user
  before_save :generate_keys

  def generate_keys
    key_service = PKeyService.new
    self.private_key ||= key_service.private_key
    self.private_key = self.private_key.delete("\n")
    self.public_key ||= key_service.public_key(self.private_key).delete("\n")
  end

  def address
    self.public_key
  end


  def balance
    clarke_service.parsed_balance(address)
  end

private

  def clarke_service
    ClarkeService.new
  end

end
