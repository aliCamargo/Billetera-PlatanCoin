class Account < ApplicationRecord
  has_many :transactions

  after_create :set_address

  validates :balance, presence:true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :address, uniqueness:true

  private
  def set_address
    self.update_attribute( :address, Digest::SHA256.hexdigest( self.id.to_s ) )
  end
end
